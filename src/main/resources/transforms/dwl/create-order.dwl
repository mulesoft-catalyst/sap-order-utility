%dw 2.0
import * from dw::core::Strings
output application/json skipNullOn="everywhere"
---
{
	
	
   controlHeaders:
   {
	       targetSystem: p('application.destination'),
	       sourceSystem: p('application.source')

   },
	salesOrderItem: payload.ORDERS05.IDOC.*E1EDP01 map ( e1EDP01 , indexOfE1EDP01 ) -> {
		sapLineID: e1EDP01.POSEX as String,
		itemNumber: (e1EDP01.*E1EDP19 filter ($.QUALF ~= "002")).IDTNR[0],
		originalQuantity: substringBefore(e1EDP01.MENGE,".") as Number,
		newQuantity: substringBefore(e1EDP01.MENGE,".") as Number,
		itemCategory: e1EDP01.PSTYV,
		material: (e1EDP01.*E1EDP19 filter ($.QUALF ~= "002")).IDTNR[0],
		plantID: e1EDP01.WERKS,
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
		sapOrderID: (payload.ORDERS05.IDOC.E1EDK01.BELNR as Number) as String,
		orderCreationDate: ((payload.ORDERS05.IDOC.*E1EDK02 filter ($.QUALF ~= "ZCR")).DATUM[0] as Date {format: "uuuuMMdd"} as String {format: "uuuu-MM-dd"} ++"T"++ (payload.ORDERS05.IDOC.*E1EDK02 filter ($.QUALF ~= "ZCR")).UZEIT[0] as String  ++"-0800")   as   DateTime   {format: "uuuu-MM-dd'T'HH:mm:ssZZZ"},
		originalDeliveryDate: (payload.ORDERS05.IDOC.*E1EDK03 filter ($.IDDAT ~= "002")).DATUM[0] as Date {format: "uuuuMMdd"} as String {format: "uuuu-MM-dd"},
		orderCreatedBy: (payload.ORDERS05.IDOC.*E1EDK02 filter ($.QUALF ~= "ZCR")).BELNR[0]
	
	}
}