%dw 2.0
output application/json skipNullOn="everywhere"
---
{
	
	
	controlHeaders:
	   {
		       targetSystem: p('application.source'),
		       sourceSystem:  p('application.destination')
	
	   },	
	salesOrderItem: payload.ORDERS05.IDOC.*E1EDP01 map ( e1EDP01 , indexOfE1EDP01 ) -> {
		sapLineID: e1EDP01.POSEX as String,
		originalQuantity: e1EDP01.MENGE,
		itemCategory: e1EDP01.PSTYV,
		material: (e1EDP01.*E1EDP19 filter ($.QUALF ~= "002")).IDTNR[0],
		plant: e1EDP01.WERKS,
		currency: e1EDP01.CURCY
	},
	salesOrderHeader: {
		
		division: (payload.ORDERS05.IDOC.*E1EDK14 filter ($.QUALF ~= "006")).ORGID[0],
		distributionChannel: (payload.ORDERS05.IDOC.*E1EDK14 filter ($.QUALF ~= "007")).ORGID[0],
		salesOrg: (payload.ORDERS05.IDOC.*E1EDK14 filter ($.QUALF ~= "008")).ORGID[0],
		salesGroup: (payload.ORDERS05.IDOC.*E1EDK14 filter ($.QUALF ~= "010")).ORGID[0],
		orderType: (payload.ORDERS05.IDOC.*E1EDK14 filter ($.QUALF ~= "012")).ORGID[0],
		soldToSAPID: (payload.ORDERS05.IDOC.*E1EDKA1 filter ($.PARVW ~= "AG")).PARTN[0],
		shipToSAPID: (payload.ORDERS05.IDOC.*E1EDKA1 filter ($.PARVW ~= "WE")).PARTN[0],
		PO: (payload.ORDERS05.IDOC.*E1EDK02 filter ($.QUALF ~= "001")).BELNR[0],
		plantID: (payload.ORDERS05.IDOC.*E1EDKA1 filter ($.PARVW ~= "OSP")).PARTN[0],
		sapOrderID: payload.ORDERS05.IDOC.E1EDK01.BELNR,
		oboOrderID: (payload.ORDERS05.IDOC.*E1EDK02 filter ($.QUALF ~= "ZRF")).BELNR[0],
		newDeliveryDate: (payload.ORDERS05.IDOC.*E1EDK03 filter ($.IDDAT ~= "002")).DATUM[0] as Date {format: "uuuuMMdd"} as String {format: "uuuu-MM-dd"},
		modifyUser: (payload.ORDERS05.IDOC.*E1EDK02 filter ($.QUALF ~= "ZUP")).BELNR[0],
		modifyDate: ((payload.ORDERS05.IDOC.*E1EDK02 filter ($.QUALF ~= "ZUP")).DATUM[0] as Date {format: "uuuuMMdd"} as String {format: "uuuu-MM-dd"} ++"T"++ (payload.ORDERS05.IDOC.*E1EDK02 filter ($.QUALF ~= "ZUP")).UZEIT[0] as String  ++"-0800")   as   DateTime   {format: "uuuu-MM-dd'T'HH:mm:ssZZZ"}
		

	}
}