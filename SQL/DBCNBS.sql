CREATE DATABASE DBCNBS

GO

USE DBCNBS;

-- Nota: Le agregue una peque;a descripcion a los campos para hacer mas facil el trabajo

CREATE TABLE DDT (
    Iddtextr NVARCHAR(MAX), -- Identificador externo de la declaraci�n.
    Cddtver INT, -- Versi�n de la declaraci�n.
    Iddtext NVARCHAR(MAX), -- Texto identificador de la declaraci�n.
    Iddt NVARCHAR(50) PRIMARY KEY, -- Identificador �nico de la declaraci�n.
    Iext NVARCHAR(MAX), -- N�mero externo.
    Cddteta NVARCHAR(MAX), -- Estado de la declaraci�n (e.g., "CANC" para cancelada).
    Dddtoficia DATETIME, -- Fecha y hora oficial de la declaraci�n.
    Dddtrectifa DATETIME, -- Fecha y hora de rectificaci�n.
    Cddtcirvis NVARCHAR(MAX), -- C�digo del circuito de servicio.
    Qddttaxchg DECIMAL(18, 4), -- Tasa de cambio de impuestos.
    Ista NVARCHAR(MAX), -- Estado de la declaraci�n.
    Cddtbur NVARCHAR(MAX), -- C�digo de la oficina de aduanas.
    Cddtburdst NVARCHAR(MAX), -- Destino de la oficina de aduanas.
    Cddtdep NVARCHAR(MAX), -- Departamento de aduanas.
    Cddtentrep NVARCHAR(MAX), -- Entrep�t (lugar de almacenamiento temporal).
    Cddtage NVARCHAR(MAX), -- Agencia de aduanas.
    Nddtimmioe NVARCHAR(MAX), -- N�mero de identificaci�n del importador/exportador.
    Lddtnomioe NVARCHAR(MAX), -- Nombre del importador/exportador.
    Cddtagr NVARCHAR(MAX), -- C�digo de la agencia responsable.
    Lddtagr NVARCHAR(MAX), -- Nombre de la agencia responsable.
    Cddtpayori NVARCHAR(MAX), -- C�digo del pa�s de origen del pago.
    Cddtpaidst NVARCHAR(MAX), -- C�digo del pa�s de destino del pago.
    Lddtnomfod NVARCHAR(MAX), -- Nombre del remitente.
    Cddtincote NVARCHAR(MAX), -- Incoterm usado (e.g., "FOB", "CIP").
    Cddtdevfob NVARCHAR(MAX), -- Moneda del valor FOB.
    Cddtdevfle NVARCHAR(MAX), -- Moneda del flete.
    Cddtdevass NVARCHAR(MAX), -- Moneda del seguro.
    Cddttransp NVARCHAR(MAX), -- C�digo del transportista.
    Cddtmdetrn NVARCHAR(MAX), -- Medio de transporte (e.g., "T" para terrestre).
    Cddtpaytrn NVARCHAR(MAX), -- C�digo del pa�s de transporte.
    Nddtart INT, -- N�mero de art�culos en la declaraci�n.
    Nddtdelai INT, -- N�mero de d�as de atraso.
    Dddtbae DATETIME, -- Fecha y hora de base.
    Dddtsalida DATETIME, -- Fecha y hora de salida.
    Dddtcancel DATETIME, -- Fecha y hora de cancelaci�n.
    Dddtechean DATETIME, -- Fecha de caducidad del EAN.
    Cddtobs NVARCHAR(MAX) -- Observaciones adicionales.
);

CREATE TABLE ART (
    Id INT PRIMARY KEY IDENTITY, -- Identificador �nico del art�culo.
    Iddt NVARCHAR(50), -- Identificador �nico de la declaraci�n al que pertenece el art�culo.
    Nart INT, -- N�mero del art�culo en la declaraci�n.
    Carttyp NVARCHAR(MAX), -- Tipo de art�culo.
    Codbenef NVARCHAR(MAX), -- C�digo del beneficiario.
    Cartetamrc NVARCHAR(MAX), -- Marca del art�culo.
    Iespnce NVARCHAR(MAX), -- C�digo del sistema arancelario.
    Cartdesc NVARCHAR(MAX), -- Descripci�n del art�culo.
    Cartpayori NVARCHAR(MAX), -- Pa�s de origen del pago.
    Cartpayacq NVARCHAR(MAX), -- Pa�s de adquisici�n del art�culo.
    Cartpayprc NVARCHAR(MAX), -- Pa�s de procedencia del art�culo.
    Iddtapu NVARCHAR(MAX), -- Identificador de la aplicaci�n del art�culo.
    Nartapu INT, -- N�mero de aplicaci�n del art�culo.
    Qartbul DECIMAL(18, 4), -- Cantidad en bultos.
    Martunitar DECIMAL(18, 4), -- Valor unitario del art�culo.
    Cartuntdcl NVARCHAR(MAX), -- Unidad de declaraci�n.
    Qartuntdcl DECIMAL(18, 4), -- Cantidad en la unidad de declaraci�n.
    Cartuntest NVARCHAR(MAX), -- Unidad estad�stica.
    Qartuntest DECIMAL(18, 4), -- Cantidad en la unidad estad�stica.
    Qartkgrbrt DECIMAL(18, 4), -- Peso bruto del art�culo.
    Qartkgrnet DECIMAL(18, 4), -- Peso neto del art�culo.
    Martfob DECIMAL(18, 4), -- Valor FOB del art�culo.
    Martfobdol DECIMAL(18, 4), -- Valor FOB en d�lares.
    Martfle DECIMAL(18, 4), -- Valor del flete.
    Martass DECIMAL(18, 4), -- Valor del seguro.
    Martemma DECIMAL(18, 4), -- Valor de embalaje.
    Martfrai DECIMAL(18, 4), -- Valor de flete interno.
    Martajuinc DECIMAL(18, 4), -- Ajuste incremental.
    Martajuded DECIMAL(18, 4), -- Ajuste decremental.
    Martbasimp DECIMAL(18, 4), -- Base imponible del art�culo.
    CONSTRAINT FK_ART_DDT FOREIGN KEY (Iddt) REFERENCES DDT(Iddt)
);

CREATE TABLE LIQ (
    Iliq NVARCHAR(50) PRIMARY KEY, -- Identificador de la liquidaci�n.
    Cliqdop NVARCHAR(MAX), -- C�digo del operador de liquidaci�n.
    Cliqeta NVARCHAR(MAX), -- Etiqueta de liquidaci�n.
    Mliq DECIMAL(18, 4), -- Monto de la liquidaci�n.
    Mliqgar DECIMAL(18, 4), -- Monto garantizado de la liquidaci�n.
    Dlippay DATETIME, -- Fecha y hora de pago.
    Clipnomope NVARCHAR(MAX), -- N�mero de operaci�n de pago.
    CONSTRAINT FK_LIQ_DDT FOREIGN KEY (Iliq) REFERENCES DDT(Iddt)
);

CREATE TABLE LQA (
    Id INT PRIMARY KEY IDENTITY, -- Identificador �nico de la liquidaci�n de art�culo.
    Iliq NVARCHAR(50), -- Identificador de la liquidaci�n a la que pertenece.
    Nart INT, -- N�mero del art�culo en la declaraci�n.
    Clqatax NVARCHAR(MAX), -- C�digo del impuesto aplicado.
    Clqatyp NVARCHAR(MAX), -- Tipo de impuesto.
    Mlqabas DECIMAL(18, 4), -- Monto base para el c�lculo del impuesto.
    Qlqacoefic DECIMAL(18, 4), -- Coeficiente del impuesto.
    Mlqa DECIMAL(18, 4), -- Monto del impuesto calculado.
    CONSTRAINT FK_LQA_LIQ FOREIGN KEY (Iliq) REFERENCES LIQ(Iliq)
);

--============================

CREATE PROCEDURE BuscarDeclaraciones
    @Nddtimmioe NVARCHAR(MAX)
AS
BEGIN
    -- Seleccionar los datos m�s relevantes de las declaraciones
    SELECT
        DDT.Iddt, -- Identificador �nico de la declaraci�n
        DDT.Cddtver, -- Versi�n de la declaraci�n
        DDT.Cddteta, -- Estado de la declaraci�n
        DDT.Dddtoficia, -- Fecha y hora oficial de la declaraci�n
        DDT.Qddttaxchg, -- Tasa de cambio de impuestos
        DDT.Nddtart, -- N�mero de art�culos en la declaraci�n
        DDT.Nddtdelai, -- N�mero de d�as de atraso
        DDT.Lddtnomioe, -- Nombre del importador/exportador
        DDT.Cddtage, -- Agencia de aduanas
        DDT.Cddtobs, -- Observaciones adicionales
        DDT.Nddtimmioe -- N�mero de identificaci�n del importador/exportador.
    FROM
        DDT
    WHERE
        DDT.Nddtimmioe = @Nddtimmioe;

    -- Seleccionar los art�culos relacionados con las declaraciones encontradas
    SELECT
        ART.Id, -- Identificador �nico del art�culo
        ART.Iddt, -- Identificador �nico de la declaraci�n
        ART.Nart, -- N�mero del art�culo en la declaraci�n
        ART.Cartdesc, -- Descripci�n del art�culo
        ART.Martunitar, -- Valor unitario del art�culo
        ART.Qartkgrnet, -- Peso neto del art�culo
        ART.Martfob -- Valor FOB del art�culo
    FROM
        ART
    INNER JOIN
        DDT ON ART.Iddt = DDT.Iddt
    WHERE
        DDT.Nddtimmioe = @Nddtimmioe;

    -- Seleccionar las liquidaciones relacionadas con las declaraciones encontradas
    SELECT
        LIQ.Iliq, -- Identificador de la liquidaci�n
        LIQ.Mliq, -- Monto de la liquidaci�n
        LIQ.Mliqgar -- Monto garantizado de la liquidaci�n
    FROM
        LIQ
    INNER JOIN
        DDT ON LIQ.Iliq = DDT.Iddt
    WHERE
        DDT.Nddtimmioe = @Nddtimmioe;

    -- Seleccionar las liquidaciones de art�culos relacionadas con las declaraciones encontradas
    SELECT
        LQA.Id, -- Identificador �nico de la liquidaci�n de art�culo
        LQA.Iliq, -- Identificador de la liquidaci�n
        LQA.Nart, -- N�mero del art�culo en la declaraci�n
        LQA.Clqatax, -- C�digo del impuesto aplicado
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

