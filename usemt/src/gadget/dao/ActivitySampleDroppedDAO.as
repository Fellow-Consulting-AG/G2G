package gadget.dao
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	
	import mx.collections.ArrayCollection;
	
	public class ActivitySampleDroppedDAO extends SupportDAO
	{
		//private var stmtDeleteByPartnerId:SQLStatement = null;
		public function ActivitySampleDroppedDAO(work:Function, sqlConnection:SQLConnection)
		{
			super(work, sqlConnection, {
				
				entity: ['Activity',   'SampleDropped'],
				id:     ['Id' ],
				columns: TEXTCOLUMNS
			}
				,{
					record_type:"Call SampDrop",
					unique:['Id'],
					clean_table:true,
					must_drop :false,
					name_column:["Sample"],
					search_columns:["Sample"],
					oracle_id:"Id",		//VAHI's not so evil kludge
					columns: { DummySiebelRowId:{type:"TEXT", init:"gadget_id" } }
				});
			_isSyncWithParent = false;
			_isGetField = true;
			//stmtDeleteByPartnerId = new SQLStatement();
			//stmtDeleteByPartnerId.text = "DELETE FROM  account_partner WHERE PartnerId = :PartnerId";
			//stmtDeleteByPartnerId.sqlConnection = sqlConnection;
			this._isSelectAll = false;
			
		}
		override public function findRelatedData(parentEntity:String , oracleId:String):ArrayCollection {
			var arr:ArrayCollection;
			stmtFindRelatedSub.text = "SELECT '" + entity + "' gadget_type, * FROM " + tableName + " WHERE ActivityId = '" + oracleId + "'";
			exec(stmtFindRelatedSub);
			var result:SQLResult = stmtFindRelatedSub.getResult();
			if (result.data == null || result.data.length == 0) {
				return new ArrayCollection();
			}
			return new ArrayCollection(result.data);
		}
//		public function deleteByPartnerId(partnerId:String):void{
//			stmtDeleteByPartnerId.parameters[":PartnerId"] = partnerId;
//			exec(stmtDeleteByPartnerId);
//		}
		override protected function getIncomingIgnoreFields():ArrayCollection{
			return new ArrayCollection(["AccountId"]);
		}
		
		override protected function getOutgoingIgnoreFields():ArrayCollection{
//			return new ArrayCollection(["AccountId",
//				"PartnerName",
//				"PrimaryContactName",
//				"PartnerExternalSystemId",
//				"PartnerIntegrationId"
//			]);
			return new ArrayCollection();
		}
		override public function getLayoutFields():Array{
			var fields:ArrayCollection =Database.fieldDao.listFields("Call SampDrop");
			
			return fields.source;
		}
		
		
		
		private var  TEXTCOLUMNS:Array = [
			"ModifiedDate",
			"CreatedDate",
			"ModifiedById",
			"CreatedById", 
			"ModId", 
			"Id", 
			"CreatedByDate",
			"Sample", 
			"ProductAllocationId", 
			"SampleLotId",
			"SampleLotNumber", 
			"ProductCategory",
			"LotNumber", 
			"CurrencyCode", 
			"ExchangeDate", 
			"SampleDroppedExternalSystemId", 
			"ProductExternalSystemId", 
			"ActivityId", 
			"ProductId",
			"ProductCategoryId", 
			"Product",
			"Quantity",
			"StartTime", 
			"EndTime",
			"UpdatedByFirstName", 
			"UpdatedByLastName",
			"UpdatedByUserSignInId", 
			"UpdatedByAlias",
			"UpdatedByFullName", 
			"UpdatedByIntegrationId", 
			"UpdatedByExternalSystemId", 
			"UpdatedByEMailAddr",
			"CreatedByFirstName",
			"CreatedByLastName",
			"CreatedByUserSignInId", 
			"CreatedByAlias",
			"CreatedByFullName", 
			"CreatedByIntegrationId", 
			"CreatedByExternalSystemId", 
			"CreatedByEMailAddr",
			"CreatedBy", 
			"ModifiedBy",
			"IndexedBoolean0", 
			"IndexedCurrency0",
			"IndexedDate0", 
			"IndexedLongText0", 
			"IndexedNumber0", 
			"IndexedPick5",
			"IndexedPick4",
			"IndexedPick3",
			"IndexedPick2", 
			"IndexedPick1", 
			"IndexedPick0", 
			"IndexedShortText0", 
			"IndexedShortText1", 
			"CustomBoolean18",
			"CustomBoolean13", 
			"CustomBoolean11", 
			"CustomBoolean14",
			"CustomBoolean10",
			"CustomBoolean17",
			"CustomBoolean1",
			"CustomBoolean15", 
			"CustomBoolean0",
			"CustomBoolean12",
			"CustomBoolean16",
			"CustomBoolean19", 
			"CustomBoolean2", 
			"CustomBoolean20",
			"CustomBoolean21",
			"CustomBoolean22",
			"CustomBoolean23",
			"CustomBoolean24",
			"CustomBoolean25",
			"CustomBoolean26",
			"CustomBoolean27", 
			"CustomBoolean28",
			"CustomBoolean29",
			"CustomCurrency1",
			"CustomBoolean9",
			"CustomCurrency0", 
			"CustomBoolean8",
			"CustomBoolean7",
			"CustomBoolean6", 
			"CustomBoolean5", 
			"CustomBoolean4", 
			"CustomBoolean3", 
			"CustomCurrency10", 
			"CustomCurrency13",
			"CustomCurrency12", 
			"CustomCurrency11",
			"CustomCurrency14", 
			"CustomCurrency15", 
			"CustomCurrency16", 
			"CustomCurrency17", 
			"CustomCurrency18",
			"CustomCurrency2",
			"CustomCurrency19",
			"CustomCurrency3",
			"CustomCurrency5",
			"CustomCurrency6",
			"CustomCurrency4",
			"CustomCurrency7",			
			"CustomDate10",
			"CustomDate50",
			"CustomDate51",
			"CustomDate44",
			"CustomDate45",
			"CustomDate48",
			"CustomDate52",
			"CustomDate53",
			"CustomDate54",	
			"CustomDate55",
			"CustomDate56",
			"CustomDate57",
			"CustomDate58", 
			"CustomDate59", 
			"CustomDate6", 
			"CustomDate7",
			"CustomDate8",
			"CustomDate9", 
			"CustomNumber21",
			"CustomNumber16", 
			"CustomNumber14",
			"CustomNumber13",
			"CustomNumber12",
			"CustomNumber11",
			"CustomNumber15",
			"CustomInteger14",
			"CustomInteger10", 
			"CustomInteger1",
			"CustomInteger0",
			"CustomCurrency8",
			"CustomCurrency9",
			"CustomDate0",
			"CustomInteger12",
			"CustomInteger11",
			"CustomInteger19",
			"CustomInteger18",
			"CustomInteger16",
			"CustomInteger15",
			"CustomInteger13",
			"CustomInteger17",
			"CustomInteger7",
			"CustomInteger9",
			"CustomInteger8",
			"CustomInteger6",
			"CustomInteger5",
			"CustomInteger4",
			"CustomInteger2",
			"CustomDate1",
			"CustomDate18",
			"CustomDate12",
			"CustomDate13",
			"CustomDate14",
			"CustomDate15",
			"CustomDate16",
			"CustomDate17",
			"CustomDate11",
			"CustomNumber20",
			"CustomInteger3",
			"CustomNumber0",
			"CustomNumber1",
			"CustomNumber10",
			"CustomNumber17",
			"CustomNumber18",
			"CustomNumber19",
			"CustomNumber2",
			"CustomDate19",
			"CustomDate2",
			"CustomDate20", 
			"CustomDate21",
			"CustomDate22",
			"CustomDate23",
			"CustomDate24",
			"CustomDate31",
			"CustomDate30",
			"CustomDate3",
			"CustomDate29",
			"CustomDate28",
			"CustomDate27",
			"CustomDate26",
			"CustomDate25",
			"CustomDate35",
			"CustomDate36",
			"CustomDate37",
			"CustomDate33",
			"CustomDate39",
			"CustomDate4",
			"CustomDate40",
			"CustomDate42",
			"CustomDate32",
			"CustomDate34",
			"CustomDate38",
			"CustomDate41",
			"CustomDate46",
			"CustomDate47",
			"CustomDate43",
			"CustomDate49",
			"CustomDate5",
			"CustomPickList83",
			"CustomPickList90",
			"CustomPickList82",
			"CustomPickList89",
			"CustomNumber28",
			"CustomNumber26",
			"CustomNumber25",				
			"CustomNumber24",
			"CustomNumber23",
			"CustomNumber22",
			"CustomNumber29",
			"CustomNumber3",
			"CustomNumber30",
			"CustomNumber27",
			"CustomNumber36",
			"CustomNumber37",
			"CustomNumber31",
			"CustomNumber32",
			"CustomPickList91",
			"CustomNumber33",
			"CustomNumber34",
			"CustomNumber35",
			"CustomNumber4",
			"CustomNumber6",
			"CustomNumber39",
			"CustomNumber38",
			"CustomNumber5",
			"CustomText17",
			"CustomText10",
			"CustomText0",
			"CustomText1",
			"CustomText11",
			"CustomNumber8",
			"CustomNumber7",
			"CustomNumber9",
			"CustomPhone0",
			"CustomPhone1",
			"CustomPhone10",
			"CustomPhone11",
			"CustomPhone12",
			"CustomPhone13",
			"CustomPhone14",
			"CustomPhone15",
			"CustomPhone18",
			"CustomPhone19",
			"CustomPhone2",
			"CustomPhone3",
			"CustomPhone4",
			"CustomPhone5",
			"CustomPhone6",
			"CustomPhone7",
			"CustomPhone8",
			"CustomPhone16",
			"CustomPhone17",
			"CustomText35",
			"CustomText34",
			"CustomText33",
			"CustomText32",
			"CustomText31",
			"CustomText30",
			"CustomText37",
			"CustomText3",
			"CustomPickList13",
			"CustomPickList17",
			"CustomPickList16",
			"CustomPickList15",
			"CustomPickList14",
			"CustomPickList12",
			"CustomPickList11",
			"CustomPickList10",
			"CustomPickList1",
			"CustomPickList0",
			"CustomPickList18",
			"CustomPhone9",
			"CustomText45",
			"CustomText4",
			"CustomText39",
			"CustomText40",
			"CustomPickList20",
			"CustomPickList19",
			"CustomPickList2",
			"CustomPickList21",
			"CustomPickList22",
			"CustomPickList28",
			"CustomPickList23",
			"CustomPickList24",
			"CustomPickList25",
			"CustomPickList26",
			"CustomPickList27",
			"CustomText24",
			"CustomText27",
			"CustomText18",
			"CustomText19",
			"CustomText2",
			"CustomText20",
			"CustomText21",
			"CustomText22",
			"CustomText23",
			"CustomText25",
			"CustomText28",
			"CustomText26",
			"CustomText29",
			"CustomText38",
			"CustomText36",
			"CustomPickList3",
			"CustomPickList29",
			"CustomPickList92",
			"CustomPickList93",
			"CustomPickList94",
			"CustomPickList95",
			"CustomPickList96",
			"CustomPickList97",
			"CustomPickList98",
			"CustomPickList99",
			"CustomText12",
			"CustomText13",
			"CustomText14",
			"CustomText15",
			"CustomText16",
			"CustomPickList34",
			"CustomPickList30",
			"CustomPickList31",
			"CustomPickList32",
			"CustomPickList33",
			"CustomPickList35",
			"CustomPickList36",
			"CustomPickList37",
			"CustomPickList38",
			"CustomPickList39",
			"CustomPickList41",
			"CustomPickList42",
			"CustomPickList43",
			"CustomPickList44",
			"CustomPickList45",
			"CustomPickList46",
			"CustomPickList47",
			"CustomPickList48",
			"CustomPickList49",
			"CustomPickList4",
			"CustomPickList40",
			"CustomPickList54",
			"CustomPickList59",
			"CustomPickList5",
			"CustomPickList50",
			"CustomPickList51",
			"CustomPickList52",
			"CustomPickList53",
			"CustomPickList55",
			"CustomPickList56",
			"CustomPickList57",
			"CustomPickList58",
			"CustomPickList6",
			"CustomPickList7",
			"CustomPickList68",
			"CustomPickList67",
			"CustomPickList66",
			"CustomPickList65",
			"CustomPickList64",
			"CustomPickList63",
			"CustomPickList62",
			"CustomPickList61",
			"CustomPickList69",
			"CustomPickList60",
			"CustomPickList8",
			"CustomPickList78",
			"CustomPickList77",
			"CustomPickList76",
			"CustomPickList75",
			"CustomPickList74",
			"CustomPickList73",
			"CustomPickList72",
			"CustomPickList71",
			"CustomPickList70",
			"CustomPickList79",
			"CustomPickList81",
			"CustomPickList80",
			"CustomPickList9",
			"CustomPickList88",
			"CustomPickList87",
			"CustomPickList86",
			"CustomPickList85",
			"CustomPickList84",
			"CustomText41",
			"CustomText42",
			"CustomText43",
			"CustomText44",
			"CustomText46",
			"CustomText47",
			"CustomText48",
			"CustomText49",
			"CustomText5",
			"CustomText59",
			"CustomText50",
			"CustomText51",
			"CustomText52",
			"CustomText53",
			"CustomText54",
			"CustomText55",
			"CustomText56",
			"CustomText57",
			"CustomText58",
			"CustomBoolean33",
			"CustomBoolean34",
			"CustomInteger20",
			"CustomInteger21",
			"CustomInteger22",
			"CustomInteger23",
			"CustomInteger24",
			"CustomInteger25",
			"CustomInteger26",
			"CustomText60",
			"CustomText61",
			"CustomText62",
			"CustomText63",
			"CustomText64",
			"CustomText65",
			"CustomText66",
			"CustomText67",
			"CustomText68",
			"CustomText69",
			"CustomText6",
			"CustomText75",
			"CustomText79",
			"CustomText78",
			"CustomText77",
			"CustomText76",
			"CustomText74",
			"CustomText73",
			"CustomText72",
			"CustomText71",
			"CustomText8",
			"CustomText7",
			"CustomText70",
			"CustomNumber53",
			"CustomNumber54",
			"CustomNumber55",
			"CustomNumber56",
			"CustomNumber57",
			"CustomNumber58",
			"CustomNumber59",
			"CustomNumber60",
			"CustomNumber61",
			"CustomNumber62",
			"CustomText9",
			"CustomText86",
			"CustomText90",
			"CustomText80", 
			"CustomText81",
			"CustomText82",
			"CustomText83", 
			"CustomText84",
			"CustomText85", 
			"CustomInteger27", 
			"CustomInteger28", 
			"CustomInteger29", 
			"CustomInteger30", 
			"CustomInteger31", 
			"CustomInteger32", 
			"CustomInteger33", 
			"CustomInteger34", 
			"CustomNumber40", 
			"CustomNumber41", 
			"CustomNumber42", 
			"CustomNumber43", 
			"CustomText87", 
			"CustomText89", 
			"CustomText88", 
			"CustomText91", 
			"CustomText98", 
			"CustomText97", 
			"CustomText96", 
			"CustomText95", 
			"CustomText94", 
			"CustomText93", 
			"CustomText92", 
			"CustomText99", 
			"CustomBoolean30", 
			"CustomBoolean31",
			"CustomBoolean32",
			"CustomNumber44", 
			"CustomNumber45", 
			"CustomNumber46", 
			"CustomNumber47", 
			"CustomNumber48", 
			"CustomNumber49", 
			"CustomNumber50", 
			"CustomNumber51", 
			"CustomNumber52", 
			"CustomCurrency21", 
			"CustomCurrency22", 
			"CustomCurrency23", 
			"CustomCurrency24", 
			"CustomCurrency20"];
	}
}