using System;
using System.IO;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using System.IO.Compression;
using Microsoft.AspNetCore.Mvc;
using PruebaTecnica2.Models;
using Newtonsoft.Json.Linq;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace PruebaTecnica2.Controllers
{
    public class DataController : Controller
    {
        private readonly HttpClient _httpClient;
        private readonly DBCNBSContext _context;

        public DataController(HttpClient httpClient, DBCNBSContext context)
        {
            _httpClient = httpClient;
            _context = context;
        }

        public IActionResult Index(string fechaConsultar)
        {
            if (string.IsNullOrEmpty(fechaConsultar))
            {
                fechaConsultar = "2021-06-20";
            }

            ViewBag.FechaConsultar = fechaConsultar;
            return View();
        }

        public async Task<string> GetJson(string fechaConsultar)
        {
            if (string.IsNullOrEmpty(fechaConsultar))
            {
                fechaConsultar = "2021-06-20";
            }

            string apiUrl = $"https://iis-des.cnbs.gob.hn/ws.TestData/api/data?Fecha={fechaConsultar}";
            string apiKey = "MEYwMEJGQ0E3QUNDN0MxNTg2M0UyOEE1QTU0MTcwM0FBQjUwNjE4MkFGNjQ0RjMyQUNCMDI1OTdDMjUwMDREOA==";

            using (var requestMessage = new HttpRequestMessage(HttpMethod.Get, apiUrl))
            {
                requestMessage.Headers.Add("apikey", apiKey);

                var response = await _httpClient.SendAsync(requestMessage);

                if (response.IsSuccessStatusCode)
                {
                    var xmlContent = await response.Content.ReadAsStringAsync();
                    XDocument xmlDocument = XDocument.Parse(xmlContent);

                    var datosComprimidosElement = xmlDocument.Root.Element("datosComprimidos");
                    if (datosComprimidosElement != null)
                    {
                        var compressedData = datosComprimidosElement.Value;
                        var decompressedJson = await DecompressAsync(compressedData);
                        return decompressedJson;
                    }

                    return "No se encontraron datos comprimidos.";
                }
                else
                {
                    return $"Error: {response.StatusCode}";
                }
            }
        }

        public async Task<IActionResult> SaveData(string fechaConsultar)
        {
            if (string.IsNullOrEmpty(fechaConsultar))
            {
                fechaConsultar = "2021-06-20";
            }

            try
            {
                var jsonData = await GetJson(fechaConsultar);

                JArray data = JArray.Parse(jsonData);

                foreach (var item in data)
                {
                    var ddt = item["DDT"].ToObject<DDT>();
                    var existingDdt = await _context.DDT.FindAsync(ddt.Iddt);
                    if (existingDdt == null)
                    {
                        _context.DDT.Add(ddt);
                    }
                    //else
                    //{
                    //    _context.Entry(existingDdt).CurrentValues.SetValues(ddt);
                    //}

                    if (item["ART"] != null)
                    {
                        foreach (var art in item["ART"])
                        {
                            var article = art.ToObject<ART>();
                            var existingArt = await _context.ART.FirstOrDefaultAsync(a => a.Iddt == article.Iddt && a.Nart == article.Nart && a.Cartdesc == article.Cartdesc);
                            if (existingArt == null)
                            {
                                _context.ART.Add(article);
                            }
                            //else
                            //{
                            //    _context.Entry(existingArt).CurrentValues.SetValues(article);
                            //}
                        }
                    }

                    if (item["LIQ"] != null)
                    {
                        var liq = item["LIQ"].ToObject<LIQ>();
                        var existingLiq = await _context.LIQ.FindAsync(liq.Iliq);
                        if (existingLiq == null)
                        {
                            _context.LIQ.Add(liq);
                        }
                        //else
                        //{
                        //    _context.Entry(existingLiq).CurrentValues.SetValues(liq);
                        //}
                    }

                    if (item["LQA"] != null)
                    {
                        foreach (var lqa in item["LQA"])
                        {
                            var liquidacion = lqa.ToObject<LQA>();
                            var existingLqa = await _context.LQA.FirstOrDefaultAsync(l => l.Iliq == liquidacion.Iliq && l.Nart == liquidacion.Nart && l.Clqatax == liquidacion.Clqatax);
                            if (existingLqa == null)
                            {
                                _context.LQA.Add(liquidacion);
                            }
                            //else
                            //{
                            //    _context.Entry(existingLqa).CurrentValues.SetValues(liquidacion);
                            //}
                        }
                    }
                }

                await _context.SaveChangesAsync();
                return Ok("Datos guardados exitosamente.");
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = $"Error: {ex.Message}", innerException = ex.InnerException?.Message });
            }
        }

        public async Task<IActionResult> ViewJson(string fechaConsultar)
        {
            if (string.IsNullOrEmpty(fechaConsultar))
            {
                fechaConsultar = "2021-06-20";
            }

            var jsonData = await GetJson(fechaConsultar);

            return Content(jsonData, "application/json");
        }

        [HttpGet]
        public async Task<IActionResult> ExploreData(string nddtimmioe)
        {
            try
            {
                var connectionString = _context.Database.GetDbConnection().ConnectionString;
                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    using (var command = new SqlCommand("BuscarDeclaraciones", connection))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@Nddtimmioe", nddtimmioe);

                        using (var reader = await command.ExecuteReaderAsync())
                        {
                            var result = new
                            {
                                ddt = new List<object>(),
                                art = new List<object>(),
                                liq = new List<object>(),
                                lqa = new List<object>()
                            };

                            // Leer datos de DDT
                            while (await reader.ReadAsync())
                            {
                                result.ddt.Add(new
                                {
                                    Iddt = reader["Iddt"],
                                    Cddtver = reader["Cddtver"],
                                    Cddteta = reader["Cddteta"],
                                    Dddtoficia = reader["Dddtoficia"],
                                    Qddttaxchg = reader["Qddttaxchg"],
                                    Nddtart = reader["Nddtart"],
                                    Nddtdelai = reader["Nddtdelai"],
                                    Lddtnomioe = reader["Lddtnomioe"],
                                    Cddtage = reader["Cddtage"],
                                    Cddtobs = reader["Cddtobs"],
                                    Nddtimmioe = reader["Nddtimmioe"]
                                });
                            }

                            // Verificar si no se encontraron registros en DDT
                            if (result.ddt.Count == 0)
                            {
                                return Json(new { message = "No se encontraron registros para este número de identificación." });
                            }

                            // Mover al siguiente resultado
                            await reader.NextResultAsync();

                            // Leer datos de ART
                            while (await reader.ReadAsync())
                            {
                                result.art.Add(new
                                {
                                    Id = reader["Id"],
                                    Iddt = reader["Iddt"],
                                    Nart = reader["Nart"],
                                    Cartdesc = reader["Cartdesc"],
                                    Martunitar = reader["Martunitar"],
                                    Qartkgrnet = reader["Qartkgrnet"],
                                    Martfob = reader["Martfob"]
                                });
                            }

                            // Mover al siguiente resultado
                            await reader.NextResultAsync();

                            // Leer datos de LIQ
                            while (await reader.ReadAsync())
                            {
                                result.liq.Add(new
                                {
                                    Iliq = reader["Iliq"],
                                    Mliq = reader["Mliq"],
                                    Mliqgar = reader["Mliqgar"]
                                });
                            }

                            // Mover al siguiente resultado
                            await reader.NextResultAsync();

                            // Leer datos de LQA
                            while (await reader.ReadAsync())
                            {
                                result.lqa.Add(new
                                {
                                    Id = reader["Id"],
                                    Iliq = reader["Iliq"],
                                    Nart = reader["Nart"],
                                    Clqatax = reader["Clqatax"],
                                    Mlqa = reader["Mlqa"]
                                });
                            }

                            return Json(result);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = $"Error: {ex.Message}", innerException = ex.InnerException?.Message });
            }
        }

        public static async Task<string> DecompressAsync(string compressedString)
        {
            try
            {
                using (MemoryStream msi = new MemoryStream(Convert.FromBase64String(compressedString)))
                using (MemoryStream mso = new MemoryStream())
                {
                    using (var gs = new GZipStream(msi, CompressionMode.Decompress))
                    {
                        await gs.CopyToAsync(mso);
                    }
                    return Encoding.UTF8.GetString(mso.ToArray());
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
