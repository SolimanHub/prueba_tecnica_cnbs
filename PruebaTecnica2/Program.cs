using Microsoft.EntityFrameworkCore;
using PruebaTecnica2.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.builder.Services.AddControllersWithViews();
builder.Services.AddControllersWithViews();
builder.Services.AddHttpClient(); // Agrega el cliente HTTP
builder.Services.AddDbContext<DBCNBSContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DBCNBS"))
           .EnableSensitiveDataLogging() // Habilitar el registro detallado de datos
           .EnableDetailedErrors());     // Habilitar errores detallados

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
}
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    //pattern: "{controller=Home}/{action=Index}/{id?}");
    pattern: "{controller=Data}/{action=Index}/{fechaConsultar?}");

app.MapControllerRoute(
    name: "getdata",
    pattern: "data/{fechaConsultar?}",
    defaults: new { controller = "Data", action = "Index" });

app.MapControllerRoute(
    name: "viewjson",
    pattern: "data/viewjson",
    defaults: new { controller = "Data", action = "ViewJson" });

app.Run();
