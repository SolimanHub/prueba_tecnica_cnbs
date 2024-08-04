CREATE DATABASE DBCNBS

GO

USE DBCNBS;

-- Nota: Le agregue una peque;a descripcion a los campos para hacer mas facil el trabajo

CREATE TABLE DDT (
    Iddtextr NVARCHAR(MAX), -- Identificador externo de la declaración.
    Cddtver INT, -- Versión de la declaración.
    Iddtext NVARCHAR(MAX), -- Texto identificador de la declaración.
    Iddt NVARCHAR(50) PRIMARY KEY, -- Identificador único de la declaración.
    Iext NVARCHAR(MAX), -- Número externo.
    Cddteta NVARCHAR(MAX), -- Estado de la declaración (e.g., "CANC" para cancelada).
    Dddtoficia DATETIME, -- Fecha y hora oficial de la declaración.
    Dddtrectifa DATETIME, -- Fecha y hora de rectificación.
    Cddtcirvis NVARCHAR(MAX), -- Código del circuito de servicio.
    Qddttaxchg DECIMAL(18, 4), -- Tasa de cambio de impuestos.
    Ista NVARCHAR(MAX), -- Estado de la declaración.
    Cddtbur NVARCHAR(MAX), -- Código de la oficina de aduanas.
    Cddtburdst NVARCHAR(MAX), -- Destino de la oficina de aduanas.
    Cddtdep NVARCHAR(MAX), -- Departamento de aduanas.
    Cddtentrep NVARCHAR(MAX), -- Entrepôt (lugar de almacenamiento temporal).
    Cddtage NVARCHAR(MAX), -- Agencia de aduanas.
    Nddtimmioe NVARCHAR(MAX), -- Número de identificación del importador/exportador.
    Lddtnomioe NVARCHAR(MAX), -- Nombre del importador/exportador.
    Cddtagr NVARCHAR(MAX), -- Código de la agencia responsable.
    Lddtagr NVARCHAR(MAX), -- Nombre de la agencia responsable.
    Cddtpayori NVARCHAR(MAX), -- Código del país de origen del pago.
    Cddtpaidst NVARCHAR(MAX), -- Código del país de destino del pago.
    Lddtnomfod NVARCHAR(MAX), -- Nombre del remitente.
    Cddtincote NVARCHAR(MAX), -- Incoterm usado (e.g., "FOB", "CIP").
    Cddtdevfob NVARCHAR(MAX), -- Moneda del valor FOB.
    Cddtdevfle NVARCHAR(MAX), -- Moneda del flete.
    Cddtdevass NVARCHAR(MAX), -- Moneda del seguro.
    Cddttransp NVARCHAR(MAX), -- Código del transportista.
    Cddtmdetrn NVARCHAR(MAX), -- Medio de transporte (e.g., "T" para terrestre).
    Cddtpaytrn NVARCHAR(MAX), -- Código del país de transporte.
    Nddtart INT, -- Número de artículos en la declaración.
    Nddtdelai INT, -- Número de días de atraso.
    Dddtbae DATETIME, -- Fecha y hora de base.
    Dddtsalida DATETIME, -- Fecha y hora de salida.
    Dddtcancel DATETIME, -- Fecha y hora de cancelación.
    Dddtechean DATETIME, -- Fecha de caducidad del EAN.
    Cddtobs NVARCHAR(MAX) -- Observaciones adicionales.
);

CREATE TABLE ART (
    Id INT PRIMARY KEY IDENTITY, -- Identificador único del artículo.
    Iddt NVARCHAR(50), -- Identificador único de la declaración al que pertenece el artículo.
    Nart INT, -- Número del artículo en la declaración.
    Carttyp NVARCHAR(MAX), -- Tipo de artículo.
    Codbenef NVARCHAR(MAX), -- Código del beneficiario.
    Cartetamrc NVARCHAR(MAX), -- Marca del artículo.
    Iespnce NVARCHAR(MAX), -- Código del sistema arancelario.
    Cartdesc NVARCHAR(MAX), -- Descripción del artículo.
    Cartpayori NVARCHAR(MAX), -- País de origen del pago.
    Cartpayacq NVARCHAR(MAX), -- País de adquisición del artículo.
    Cartpayprc NVARCHAR(MAX), -- País de procedencia del artículo.
    Iddtapu NVARCHAR(MAX), -- Identificador de la aplicación del artículo.
    Nartapu INT, -- Número de aplicación del artículo.
    Qartbul DECIMAL(18, 4), -- Cantidad en bultos.
    Martunitar DECIMAL(18, 4), -- Valor unitario del artículo.
    Cartuntdcl NVARCHAR(MAX), -- Unidad de declaración.
    Qartuntdcl DECIMAL(18, 4), -- Cantidad en la unidad de declaración.
    Cartuntest NVARCHAR(MAX), -- Unidad estadística.
    Qartuntest DECIMAL(18, 4), -- Cantidad en la unidad estadística.
    Qartkgrbrt DECIMAL(18, 4), -- Peso bruto del artículo.
    Qartkgrnet DECIMAL(18, 4), -- Peso neto del artículo.
    Martfob DECIMAL(18, 4), -- Valor FOB del artículo.
    Martfobdol DECIMAL(18, 4), -- Valor FOB en dólares.
    Martfle DECIMAL(18, 4), -- Valor del flete.
    Martass DECIMAL(18, 4), -- Valor del seguro.
    Martemma DECIMAL(18, 4), -- Valor de embalaje.
    Martfrai DECIMAL(18, 4), -- Valor de flete interno.
    Martajuinc DECIMAL(18, 4), -- Ajuste incremental.
    Martajuded DECIMAL(18, 4), -- Ajuste decremental.
    Martbasimp DECIMAL(18, 4), -- Base imponible del artículo.
    CONSTRAINT FK_ART_DDT FOREIGN KEY (Iddt) REFERENCES DDT(Iddt)
);

CREATE TABLE LIQ (
    Iliq NVARCHAR(50) PRIMARY KEY, -- Identificador de la liquidación.
    Cliqdop NVARCHAR(MAX), -- Código del operador de liquidación.
    Cliqeta NVARCHAR(MAX), -- Etiqueta de liquidación.
    Mliq DECIMAL(18, 4), -- Monto de la liquidación.
    Mliqgar DECIMAL(18, 4), -- Monto garantizado de la liquidación.
    Dlippay DATETIME, -- Fecha y hora de pago.
    Clipnomope NVARCHAR(MAX), -- Número de operación de pago.
    CONSTRAINT FK_LIQ_DDT FOREIGN KEY (Iliq) REFERENCES DDT(Iddt)
);

CREATE TABLE LQA (
    Id INT PRIMARY KEY IDENTITY, -- Identificador único de la liquidación de artículo.
    Iliq NVARCHAR(50), -- Identificador de la liquidación a la que pertenece.
    Nart INT, -- Número del artículo en la declaración.
    Clqatax NVARCHAR(MAX), -- Código del impuesto aplicado.
    Clqatyp NVARCHAR(MAX), -- Tipo de impuesto.
    Mlqabas DECIMAL(18, 4), -- Monto base para el cálculo del impuesto.
    Qlqacoefic DECIMAL(18, 4), -- Coeficiente del impuesto.
    Mlqa DECIMAL(18, 4), -- Monto del impuesto calculado.
    CONSTRAINT FK_LQA_LIQ FOREIGN KEY (Iliq) REFERENCES LIQ(Iliq)
);

--============================

CREATE PROCEDURE BuscarDeclaraciones
    @Nddtimmioe NVARCHAR(MAX)
AS
BEGIN
    -- Seleccionar los datos más relevantes de las declaraciones
    SELECT
        DDT.Iddt, -- Identificador único de la declaración
        DDT.Cddtver, -- Versión de la declaración
        DDT.Cddteta, -- Estado de la declaración
        DDT.Dddtoficia, -- Fecha y hora oficial de la declaración
        DDT.Qddttaxchg, -- Tasa de cambio de impuestos
        DDT.Nddtart, -- Número de artículos en la declaración
        DDT.Nddtdelai, -- Número de días de atraso
        DDT.Lddtnomioe, -- Nombre del importador/exportador
        DDT.Cddtage, -- Agencia de aduanas
        DDT.Cddtobs, -- Observaciones adicionales
        DDT.Nddtimmioe -- Número de identificación del importador/exportador.
    FROM
        DDT
    WHERE
        DDT.Nddtimmioe = @Nddtimmioe;

    -- Seleccionar los artículos relacionados con las declaraciones encontradas
    SELECT
        ART.Id, -- Identificador único del artículo
        ART.Iddt, -- Identificador único de la declaración
        ART.Nart, -- Número del artículo en la declaración
        ART.Cartdesc, -- Descripción del artículo
        ART.Martunitar, -- Valor unitario del artículo
        ART.Qartkgrnet, -- Peso neto del artículo
        ART.Martfob -- Valor FOB del artículo
    FROM
        ART
    INNER JOIN
        DDT ON ART.Iddt = DDT.Iddt
    WHERE
        DDT.Nddtimmioe = @Nddtimmioe;

    -- Seleccionar las liquidaciones relacionadas con las declaraciones encontradas
    SELECT
        LIQ.Iliq, -- Identificador de la liquidación
        LIQ.Mliq, -- Monto de la liquidación
        LIQ.Mliqgar -- Monto garantizado de la liquidación
    FROM
        LIQ
    INNER JOIN
        DDT ON LIQ.Iliq = DDT.Iddt
    WHERE
        DDT.Nddtimmioe = @Nddtimmioe;

    -- Seleccionar las liquidaciones de artículos relacionadas con las declaraciones encontradas
    SELECT
        LQA.Id, -- Identificador único de la liquidación de artículo
        LQA.Iliq, -- Identificador de la liquidación
        LQA.Nart, -- Número del artículo en la declaración
        LQA.Clqatax, -- Código del impuesto aplicado
        LQA.Mlqa -- Monto del impuesto calculado
    FROM
        LQA
    INNER JOIN
        LIQ ON LQA.Iliq = LIQ.Iliq
    INNER JOIN
        DDT ON LIQ.Iliq = DDT.Iddt
    WHERE
        DDT.Nddtimmioe = @Nddtimmioe;
END;

-- Obtener la lista de Nddtimmioe disponibles
-- select distinct Nddtimmioe from ddt;

-- Ejecutar pruebas del procedimiento
-- EXEC BuscarDeclaraciones @Nddtimmioe = '07039012462860';

