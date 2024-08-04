document.getElementById("viewJsonButton").addEventListener("click", function () {
    var fechaConsultar = document.getElementById("fechaDeclaracion").value || "2021-06-20";
    window.open('/data/viewjson?fechaConsultar=' + fechaConsultar, '_blank');
});

document.getElementById("saveDataButton").addEventListener("click", function () {
    document.getElementById("resultMessage").innerText = "Procesando la solicitud, por favor espere mientras los datos se almacenan correctamente. Recibirá una confirmación una vez que el proceso se haya completado con éxito.";
    var fechaConsultar = document.getElementById("fechaDeclaracion").value || "2021-06-20";
    fetch('/data/savedata?fechaConsultar=' + fechaConsultar, {
        method: 'POST'
    })
        .then(response => response.text())
        .then(data => {
            document.getElementById("resultMessage").innerText = data;
            document.getElementById("resultMessage").style.color = "green";
        })
        .catch(error => {
            document.getElementById("resultMessage").innerText = "Error: " + error;
            document.getElementById("resultMessage").style.color = "red";
        });
});

document.getElementById("exploreDataButton").addEventListener("click", function () {
    document.getElementById("exploreDataForm").style.display = "block";
    document.getElementById("exploreDataResult").innerText = "Cargando datos ...";
});

document.getElementById("showDataButton").addEventListener("click", function () {
    var nddtimmioe = document.getElementById("nddtimmioe").value;
    fetch('/data/exploredata?nddtimmioe=' + nddtimmioe)
        .then(response => response.json())
        .then(data => {
            if (data.message) {
                document.getElementById("exploreDataResult").innerText = data.message;
            } else {
                var resultHtml = "<h3>DDT (Declaración de Datos de Tránsito)</h3><div class='card-container'>";
                data.ddt.forEach(function (item) {
                    resultHtml += "<div class='card'><div class='card-body'>";
                    resultHtml += "<strong>Identificador único de la declaración:</strong> " + item.iddt + "<br>";
                    resultHtml += "<strong>Versión de la declaración:</strong> " + item.cddtver + "<br>";
                    resultHtml += "<strong>Estado de la declaración:</strong> " + item.cddteta + "<br>";
                    resultHtml += "<strong>Fecha y hora oficial de la declaración:</strong> " + item.dddtoficia + "<br>";
                    resultHtml += "<strong>Tasa de cambio de impuestos:</strong> " + item.qddttaxchg + "<br>";
                    resultHtml += "<strong>Número de artículos en la declaración:</strong> " + item.nddtart + "<br>";
                    resultHtml += "<strong>Número de días de atraso:</strong> " + item.nddtdelai + "<br>";
                    resultHtml += "<strong>Nombre del importador/exportador:</strong> " + item.lddtnomioe + "<br>";
                    resultHtml += "<strong>Agencia de aduanas:</strong> " + item.cddtage + "<br>";
                    resultHtml += "<strong>Observaciones adicionales:</strong> " + item.cddtobs + "<br>";
                    resultHtml += "<strong>Número de identificación del importador/exportador:</strong> " + item.nddtimmioe + "</div></div>";
                });
                resultHtml += "</div>";

                resultHtml += "<h3>ART (Artículos)</h3><div class='card-container'>";
                data.art.forEach(function (item) {
                    resultHtml += "<div class='card'><div class='card-body'>";
                    resultHtml += "<strong>Identificador único del artículo:</strong> " + item.id + "<br>";
                    resultHtml += "<strong>Identificador único de la declaración:</strong> " + item.iddt + "<br>";
                    resultHtml += "<strong>Número del artículo en la declaración:</strong> " + item.nart + "<br>";
                    resultHtml += "<strong>Descripción del artículo:</strong> " + item.cartdesc + "<br>";
                    resultHtml += "<strong>Valor unitario del artículo:</strong> " + item.martunitar + "<br>";
                    resultHtml += "<strong>Peso neto del artículo:</strong> " + item.qartkgrnet + "<br>";
                    resultHtml += "<strong>Valor FOB del artículo:</strong> " + item.martfob + "</div></div>";
                });
                resultHtml += "</div>";

                resultHtml += "<h3>LIQ (Liquidaciones)</h3><div class='card-container'>";
                data.liq.forEach(function (item) {
                    resultHtml += "<div class='card'><div class='card-body'>";
                    resultHtml += "<strong>Identificador de la liquidación:</strong> " + item.iliq + "<br>";
                    resultHtml += "<strong>Monto de la liquidación:</strong> " + item.mliq + "<br>";
                    resultHtml += "<strong>Monto garantizado de la liquidación:</strong> " + item.mliqgar + "</div></div>";
                });
                resultHtml += "</div>";

                resultHtml += "<h3>LQA (Liquidaciones de Artículos)</h3><div class='card-container'>";
                data.lqa.forEach(function (item) {
                    resultHtml += "<div class='card'><div class='card-body'>";
                    resultHtml += "<strong>Identificador único de la liquidación de artículo:</strong> " + item.id + "<br>";
                    resultHtml += "<strong>Identificador de la liquidación:</strong> " + item.iliq + "<br>";
                    resultHtml += "<strong>Número del artículo en la declaración:</strong> " + item.nart + "<br>";
                    resultHtml += "<strong>Código del impuesto aplicado:</strong> " + item.clqatax + "<br>";
                    resultHtml += "<strong>Monto del impuesto calculado:</strong> " + item.mlqa + "</div></div>";
                });
                resultHtml += "</div>";

                document.getElementById("exploreDataResult").innerHTML = resultHtml;
            }
        })
        .catch(error => {
            document.getElementById("exploreDataResult").innerText = "Error: " + error;
        });
});
