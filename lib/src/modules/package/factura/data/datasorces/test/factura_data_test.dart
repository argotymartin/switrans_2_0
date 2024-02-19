import 'package:switrans_2_0/src/modules/package/factura/domain/entities/adicion.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/descuento.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';

class FacturaDataTest {
  static final List<Empresa> empresasResponse = [
    Empresa(codigo: 1, nombre: "MCT", nit: "83004861"),
    Empresa(codigo: 2, nombre: "MARKETING E INVERSIONES S.A.S.", nit: "8060029537"),
    Empresa(codigo: 12, nombre: "FERRICAR S.A.S", nit: "9010511090"),
  ];

  static final List<Cliente> clinetesResponse = [
    Cliente(codigo: 2988, nombre: "ROLDAN Y COMPANIA S.A.S.", identificacion: "890903069", telefono: "3520687"),
    Cliente(codigo: 2486, nombre: "INDUFAST S.A.S", identificacion: "900549320", telefono: "6917705"),
    Cliente(codigo: 2975, nombre: "E2 ENERGIA EFICIENTE S.A. E.S.P.", identificacion: "802025052", telefono: "3306266"),
    Cliente(codigo: 2740, nombre: "PEGOMAX SAS", identificacion: "830089785", telefono: "7265033"),
    Cliente(codigo: 1409, nombre: "GEODIS COLOMBIA LTDA.", identificacion: "830055467", telefono: "6020100"),
  ];

  static final List<Documento> remesasResponse = [
    Documento(
      remesa: 443534,
      impreso: "01048-15895",
      fechaCreacion: "2021-11-23",
      estadoCodigo: 334,
      estadoNombre: "CRUZADO",
      empresa: 1,
      cierreTarifa: true,
      cencosCodigo: 81,
      cencosNombre: "MONTEVIDEO OPERACIONES MCT SAS",
      tipoRemesa: "URBANOS",
      origen: "BOGOTA, D.C.",
      destino: "BOGOTA, D.C.",
      observacion:
          "PLANILA PARA LEGALIZAR SERVICIO URBANO CANCELADO POR EL CLIENTE PERACION TEXMODA AEROPUERTO SIN VERIFICAR PESO NI CONTENIDO",
      observacionFactura: "Esto es otra Observacion",
      remision: "Esto es una Remision",
      rcp: 0.0,
      total: 100.0,
      flete: 100000.0,
      anulacionTrafico: false,
      adiciones: [],
      descuentos: [Descuento(codigo: 10948, tipo: "error Cliente", valor: 100.0)],
    ),
    Documento(
      remesa: 736918,
      impreso: "01043-67921",
      fechaCreacion: "2024-01-02",
      estadoCodigo: 3,
      estadoNombre: "PLANILLADA",
      empresa: 1,
      cierreTarifa: false,
      cencosCodigo: 61,
      cencosNombre: "FUNZA MCT SAS",
      tipoRemesa: "CONTENEDOR VACIO",
      origen: "FUNZA",
      destino: "CARTAGENA DE INDIAS",
      observacion:
          "VACIO EN EXPRESO D.O:  RTMOE000103736    -    BL:  RTMOE000103736 LLEVA 1X40HC  HLBU2355011 COMPROMISO DE ENTREGA EL DIA 4-1-23",
      observacionFactura: "Esto es otra Observacion",
      remision: "D.O:  RTMOE000103736    -    BL:  RTMOE000103736",
      rcp: 3660000.0,
      total: 3400000.0,
      flete: 3400000.0,
      anulacionTrafico: true,
      adiciones: [Adicion(codigo: 202444, tipo: "devolucion contenedor 1x40", valor: 260000.0)],
      descuentos: [],
    ),
    Documento(
      remesa: 736801,
      impreso: "01085-4418",
      fechaCreacion: "2024-01-02",
      estadoCodigo: 3,
      estadoNombre: "PLANILLADA",
      empresa: 1,
      cierreTarifa: false,
      cencosCodigo: 112,
      cencosNombre: "MEDELLIN - MCT SAS",
      tipoRemesa: "NORMAL",
      origen: "BELLO",
      destino: "TENJO",
      observacion:
          "LLEVA CANTIDAD DE UNIDADES CARGADAS SEGUN REMISIONES,FACTURAS O  DOCUMENTOS ENTREGADO POR EL CLIENTE O REMITENTE EN EL LUGAR DE …",
      observacionFactura: "Esto es otra Observacion",
      remision: "DO H&M CC TESORO ENVIGADO ARKADIA Y FABRICATO",
      rcp: 302500.0,
      total: 202500.0,
      flete: 202500.0,
      anulacionTrafico: false,
      adiciones: [
        Adicion(codigo: 202245, tipo: "punto adicional", valor: 30000.0),
        Adicion(codigo: 202244, tipo: "descargue", valor: 70000.0),
      ],
      descuentos: [],
    ),
    Documento(
      remesa: 736978,
      impreso: "01043-67926",
      fechaCreacion: "2024-01-02",
      estadoCodigo: 3,
      estadoNombre: "PLANILLADA",
      empresa: 1,
      cierreTarifa: false,
      cencosCodigo: 61,
      cencosNombre: "FUNZA MCT SAS",
      tipoRemesa: "URBANOS",
      origen: "FUNZA",
      destino: "FUNZA",
      observacion:
          "SERVICIO SOLICITADO POR ALEXIS OCAMPO PARA EL DIA 03-01-2024  TURBO DE PLACA WFV844 CONDUCTOR FABIO ROJAS    ESCOLTA LACOSTE RET…",
      observacionFactura: "",
      remision: "",
      rcp: 335000.0,
      total: 250000.0,
      flete: 250000.0,
      anulacionTrafico: false,
      adiciones: [Adicion(codigo: 202305, tipo: "acompanamiento", valor: 85000.0)],
      descuentos: [],
    )
  ];
}
