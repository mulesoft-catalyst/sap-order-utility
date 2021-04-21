%dw 2.0
import * from dw::core::Strings
output application/xml skipNullOn = "everywhere"
---
{
	BAPI_SALESORDER_CHANGE: {
		"import": {
			ORDER_HEADER_IN: {
				XBLNR: vars.oboOrderID,
				
			},
			ORDER_HEADER_INX: {
				UPDATEFLAG: "U",
				XBLNR:  "X" 
			},
			SALESDOCUMENT: leftPad(payload.ORDERS05.IDOC.E1EDK01.BELNR as Number, 10, 0)
		}
	}
}