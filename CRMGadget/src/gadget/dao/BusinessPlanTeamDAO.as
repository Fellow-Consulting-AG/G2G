//Not used (Account Team cannot be fetched as it is missing.)
package gadget.dao
{
	import flash.data.SQLConnection;
	
	import mx.collections.ArrayCollection;

	public class BusinessPlanTeamDAO extends SupportDAO implements ITeam	{

		public function BusinessPlanTeamDAO(sqlConnection:SQLConnection, workerFunction:Function) {
			super( workerFunction,sqlConnection,
				{
					
					entity: ['BusinessPlan',   'Team'],
					id:     ['ParentId', 'UserId' ],
					columns: TEXTCOLUMNS
				}
					,{
						record_type:"CRMODLS_BusinessPlanTeam",
						unique:['ParentId,UserId','Id'],
						clean_table:false,
						must_drop:false,
						name_column:["FirstName","LastName"],
						search_columns:["FirstName","LastName"],
						oracle_id:"Id",		//VAHI's not so evil kludge
						columns: { DummySiebelRowId:{type:"TEXT", init:"gadget_id" } }
					});
			_isSyncWithParent = false;
			_isGetField = true;
		
			
		}
		
		
		override protected function getOutgoingIgnoreFields():ArrayCollection{
			return new ArrayCollection(["UserExternalSystemId",
				"FirstName",
				"FullName",
				"LastName",
				"UserAlias"	,
				"AccountName",
				"RoleName",
				"ObjectPlanName",
				"PlanName",
				'AccessProfileName'
				
			]);
		}
		
		private var TEXTCOLUMNS:Array = [
			"ModifiedDate",
			"CreatedDate",
			"ModifiedById",
			"CreatedById",
			"ModId",
			"Id",
			"UserExternalSystemId",
			"UserEmail",
			"FullName",
			"AccessProfileId",
			"FirstName",
			"PlanName",
			"ParentId",
			"AccessProfileName",
			"AccessCode",
			"UserId",
			"LastName",
			"LoginName",
			"UserAlias",
			"RoleName",
			"ReadOnlyFlag",
			"RoleNameTranslation",
			"TeamRole",
			"CurrencyCode",
			"ExchangeDate",
			"OptimizedCustomTextLG2",
			"OptimizedCustomTextLG15",
			"OptimizedCustomTextLG21",
			"OptimizedCustomPickList1",
			"OptimizedCustomNumber33",
			"OptimizedCustomBoolean8",
			"OptimizedCustomBoolean19",
			"OptimizedCustomNumberPercent19",
			"OptimizedCustomPhone14",
			"OptimizedCustomInteger17",
			"OptimizedCustomPickList16",
			"OptimizedCustomPickList41",
			"OptimizedCustomNumberPercent16",
			"OptimizedCustomBoolean4",
			"OptimizedCustomTextSM40",
			"OptimizedCustomPickList10",
			"OptimizedCustomInteger31",
			"OptimizedCustomCurrency2",
			"OptimizedCustomBoolean25",
			"OptimizedCustomTextSM5",
			"OptimizedCustomPickList3",
			"OptimizedCustomPickList36",
			"OptimizedCustomPickList7",
			"OptimizedCustomDateTime3",
			"OptimizedCustomPhone7",
			"OptimizedCustomPickList42",
			"OptimizedCustomNumber18",
			"OptimizedCustomInteger12",
			"OptimizedCustomTextSM42",
			"OptimizedCustomTextSM36",
			"OptimizedCustomPhone23",
			"OptimizedCustomPickList38",
			"OptimizedCustomBoolean22",
			"OptimizedCustomBoolean27",
			"OptimizedCustomTextSM21",
			"OptimizedCustomPickList21",
			"OptimizedCustomDate14",
			"OptimizedCustomCurrency10",
			"OptimizedCustomBoolean3",
			"OptimizedCustomBoolean33",
			"OptimizedCustomTextLG20",
			"OptimizedCustomTextLG7",
			"OptimizedCustomTextSM17",
			"OptimizedCustomNumber10",
			"OptimizedCustomNumber16",
			"OptimizedCustomDate2",
			"OptimizedCustomCurrency0",
			"OptimizedCustomTextSM4",
			"OptimizedCustomTextSM30",
			"OptimizedCustomNumber5",
			"OptimizedCustomPhone0",
			"OptimizedCustomDateTime1",
			"OptimizedCustomBoolean18",
			"OptimizedCustomTextSM43",
			"OptimizedCustomNumber21",
			"OptimizedCustomTextSM0",
			"OptimizedCustomPickList48",
			"OptimizedCustomNumberPercent14",
			"OptimizedCustomNumber26",
			"OptimizedCustomBoolean10",
			"OptimizedCustomTextLG3",
			"OptimizedCustomPickList12",
			"OptimizedCustomPickList31",
			"OptimizedCustomNumber8",
			"OptimizedCustomNumberPercent2",
			"OptimizedCustomPhone16",
			"OptimizedCustomNumber15",
			"OptimizedCustomInteger26",
			"OptimizedCustomDate12",
			"OptimizedCustomBoolean11",
			"OptimizedCustomBoolean17",
			"OptimizedCustomBoolean23",
			"OptimizedCustomTextSM28",
			"OptimizedCustomNumber31",
			"OptimizedCustomInteger22",
			"OptimizedCustomInteger32",
			"OptimizedCustomCurrency11",
			"OptimizedCustomBoolean32",
			"OptimizedCustomBoolean6",
			"OptimizedCustomPickList28",
			"OptimizedCustomDate16",
			"OptimizedCustomBoolean1",
			"OptimizedCustomBoolean29",
			"OptimizedCustomTextLG8",
			"OptimizedCustomPickList22",
			"OptimizedCustomNumber11",
			"OptimizedCustomNumber30",
			"OptimizedCustomCurrency22",
			"OptimizedCustomDateTime0",
			"OptimizedCustomPickList26",
			"OptimizedCustomNumber32",
			"OptimizedCustomDateTime17",
			"OptimizedCustomDate19",
			"OptimizedCustomCurrency24",
			"OptimizedCustomCurrency8",
			"OptimizedCustomBoolean12",
			"OptimizedCustomPhone8",
			"OptimizedCustomPickList25",
			"OptimizedCustomPickList33",
			"OptimizedCustomNumber28",
			"OptimizedCustomBoolean21",
			"OptimizedCustomBoolean34",
			"OptimizedCustomTextLG1",
			"OptimizedCustomNumber17",
			"OptimizedCustomDateTime8",
			"OptimizedCustomDateTime7",
			"OptimizedCustomTextLG6",
			"OptimizedCustomTextSM8",
			"OptimizedCustomNumber25",
			"OptimizedCustomInteger16",
			"OptimizedCustomBoolean20",
			"OptimizedCustomTextSM26",
			"OptimizedCustomTextSM25",
			"OptimizedCustomPhone1",
			"OptimizedCustomInteger2",
			"OptimizedCustomBoolean13",
			"OptimizedCustomTextSM48",
			"OptimizedCustomTextSM31",
			"OptimizedCustomNumber4",
			"OptimizedCustomInteger0",
			"OptimizedCustomDate3",
			"OptimizedCustomCurrency4",
			"OptimizedCustomPickList15",
			"OptimizedCustomPickList24",
			"OptimizedCustomNumberPercent17",
			"OptimizedCustomInteger9",
			"OptimizedCustomBoolean15",
			"OptimizedCustomTextSM47",
			"OptimizedCustomNumberPercent10",
			"OptimizedCustomNumberPercent7",
			"OptimizedCustomBoolean2",
			"OptimizedCustomTextLG18",
			"OptimizedCustomTextSM29",
			"OptimizedCustomPickList43",                  
			"OptimizedCustomNumberPercent21",
			"OptimizedCustomNumber2",
			"OptimizedCustomInteger21",
			"OptimizedCustomDateTime2",
			"OptimizedCustomPickList6",
			"OptimizedCustomInteger19",
			"OptimizedCustomInteger5",
			"OptimizedCustomTextLG17",
			"OptimizedCustomNumberPercent22",
			"OptimizedCustomDate15",
			"OptimizedCustomDate4",
			"OptimizedCustomCurrency5",
			"OptimizedCustomTextSM23",
			"OptimizedCustomTextSM34",
			"OptimizedCustomNumberPercent6",
			"OptimizedCustomInteger24",
			"OptimizedCustomCurrency9",
			"OptimizedCustomBoolean7",
			"OptimizedCustomTextSM27",
			"OptimizedCustomTextSM24",
			"OptimizedCustomPhone21",
			"OptimizedCustomPhone2",
			"OptimizedCustomCurrency3",
			"OptimizedCustomDateTime9",
			"OptimizedCustomDateTime6",
			"OptimizedCustomPickList18",
			"OptimizedCustomInteger18",
			"OptimizedCustomInteger6",
			"OptimizedCustomTextSM6",
			"OptimizedCustomPickList29",                    
			"OptimizedCustomNumberPercent24",
			"OptimizedCustomNumberPercent8",
			"OptimizedCustomPhone4",
			"OptimizedCustomNumber0",
			"OptimizedCustomInteger15",
			"OptimizedCustomTextLG0",
			"OptimizedCustomTextSM49",
			"OptimizedCustomNumberPercent13",
			"OptimizedCustomInteger23",
			"OptimizedCustomDateTime11",
			"OptimizedCustomDate8",
			"OptimizedCustomDateTime24",
			"OptimizedCustomTextLG13",
			"OptimizedCustomPickList0",
			"OptimizedCustomPickList20",
			"OptimizedCustomNumber3",
			"OptimizedCustomInteger3",
			"OptimizedCustomDateTime10",
			"OptimizedCustomBoolean9",
			"OptimizedCustomBoolean16",
			"OptimizedCustomTextSM39",
			"OptimizedCustomCurrency15",
			"OptimizedCustomBoolean24",
			"OptimizedCustomNumberPercent11",
			"OptimizedCustomInteger8",
			"OptimizedCustomTextLG12",
			"OptimizedCustomTextSM7",
			"OptimizedCustomPhone19",
			"OptimizedCustomDate10",
			"OptimizedCustomDate7",
			"OptimizedCustomTextLG19",
			"OptimizedCustomNumberPercent5",
			"OptimizedCustomPhone12",
			"OptimizedCustomNumber29",
			"OptimizedCustomTextSM19",
			"OptimizedCustomPhone5",
			"OptimizedCustomDateTime16",
			"OptimizedCustomCurrency21",
			"OptimizedCustomTextSM20",
			"OptimizedCustomTextLG23",
			"OptimizedCustomNumberPercent1",
			"OptimizedCustomInteger33",
			"OptimizedCustomDate9",
			"OptimizedCustomBoolean31",
			"OptimizedCustomPickList11",
			"OptimizedCustomPhone17",
			"OptimizedCustomNumber27",
			"OptimizedCustomDateTime23",
			"OptimizedCustomTextLG14",
			"OptimizedCustomTextSM9",
			"OptimizedCustomInteger10",
			"OptimizedCustomDateTime19",
			"OptimizedCustomDateTime13",
			"OptimizedCustomTextLG11",
			"OptimizedCustomTextSM38",
			"OptimizedCustomTextLG4",
			"OptimizedCustomPickList2",
			"OptimizedCustomNumber6",
			"OptimizedCustomNumberPercent4",
			"OptimizedCustomPhone24",
			"OptimizedCustomInteger1",
			"OptimizedCustomBoolean14",
			"OptimizedCustomTextSM14",
			"OptimizedCustomPhone3",
			"OptimizedCustomPickList13",
			"OptimizedCustomInteger34",
			"OptimizedCustomDateTime22",
			"OptimizedCustomTextSM16",
			"OptimizedCustomTextLG22",
			"OptimizedCustomPhone6",
			"OptimizedCustomPickList34",
			"OptimizedCustomPickList9",
			"OptimizedCustomDate1",
			"OptimizedCustomTextSM37",
			"OptimizedCustomPickList47",
			"OptimizedCustomNumberPercent15",
			"OptimizedCustomNumber22",
			"OptimizedCustomDate24",
			"OptimizedCustomTextLG5",
			"OptimizedCustomPickList37",
			"OptimizedCustomPhone10",
			"OptimizedCustomTextSM3",
			"OptimizedCustomPickList4",
			"OptimizedCustomDateTime14",
			"OptimizedCustomDate6",
			"OptimizedCustomCurrency7",
			"OptimizedCustomTextLG9",
			"OptimizedCustomTextSM15",
			"OptimizedCustomPickList32",
			"OptimizedCustomPickList8",
			"OptimizedCustomNumber7",
			"OptimizedCustomNumberPercent3",
			"OptimizedCustomInteger7",
			"OptimizedCustomCurrency14",
			"OptimizedCustomBoolean28",
			"OptimizedCustomTextSM11",
			"OptimizedCustomPhone22",
			"OptimizedCustomNumber12",
			"OptimizedCustomInteger20",
			"OptimizedCustomDateTime18",
			"OptimizedCustomDate13",
			"OptimizedCustomBoolean30",
			"OptimizedCustomTextSM35",
			"OptimizedCustomPickList46",
			"OptimizedCustomPhone15",
			"OptimizedCustomPhone18",
			"OptimizedCustomNumber14",
			"OptimizedCustomNumber23",
			"OptimizedCustomDate23",
			"OptimizedCustomDate22",
			"OptimizedCustomDateTime5",
			"OptimizedCustomTextSM45",
			"OptimizedCustomTextSM32",
			"OptimizedCustomPickList14",
			"OptimizedCustomPickList45",
			"OptimizedCustomNumberPercent18",
			"OptimizedCustomNumberPercent12",
			"OptimizedCustomNumberPercent9",
			"OptimizedCustomNumber34",
			"OptimizedCustomInteger29",
			"OptimizedCustomDate0",
			"OptimizedCustomPickList27",
			"OptimizedCustomNumberPercent23",
			"OptimizedCustomNumberPercent0",
			"OptimizedCustomDate18",
			"OptimizedCustomCurrency13",
			"OptimizedCustomCurrency1",
			"OptimizedCustomBoolean0",
			"OptimizedCustomTextSM2",
			"OptimizedCustomTextSM18",
			"OptimizedCustomPickList44",
			"OptimizedCustomPhone11",
			"OptimizedCustomInteger28",
			"OptimizedCustomInteger30",
			"OptimizedCustomDate21",
			"OptimizedCustomTextLG16",
			"OptimizedCustomTextSM12",
			"OptimizedCustomNumber20",
			"OptimizedCustomInteger11",
			"OptimizedCustomPickList39",
			"OptimizedCustomNumber9",
			"OptimizedCustomCurrency16",
			"OptimizedCustomCurrency17",
			"OptimizedCustomCurrency18",
			"OptimizedCustomCurrency19",
			"OptimizedCustomBoolean5",
			"OptimizedCustomBoolean26",
			"OptimizedCustomPhone9",
			"OptimizedCustomNumber24",
			"OptimizedCustomTextSM10",
			"OptimizedCustomTextLG24",
			"OptimizedCustomPickList23",
			"OptimizedCustomPickList30",
			"OptimizedCustomPickList35",
			"OptimizedCustomNumberPercent20",
			"OptimizedCustomNumber19",
			"OptimizedCustomDateTime21",
			"OptimizedCustomCurrency12",
			"OptimizedCustomCurrency23",
			"OptimizedCustomTextLG10",
			"OptimizedCustomTextSM22",
			"OptimizedCustomPhone13",
			"OptimizedCustomInteger13",
			"OptimizedCustomInteger27",
			"OptimizedCustomDateTime15",
			"OptimizedCustomDate11",
			"OptimizedCustomDate17",
			"OptimizedCustomCurrency20",
			"OptimizedCustomPickList19",
			"OptimizedCustomPickList40",
			"OptimizedCustomInteger14",
			"OptimizedCustomDate20",
			"OptimizedCustomTextSM44",
			"OptimizedCustomTextSM41",
			"OptimizedCustomPhone20",
			"OptimizedCustomDateTime12",
			"OptimizedCustomDate5",
			"OptimizedCustomCurrency6",
			"OptimizedCustomTextSM1",
			"OptimizedCustomTextSM13",
			"OptimizedCustomPickList17",
			"OptimizedCustomPickList49",
			"OptimizedCustomNumber13",
			"OptimizedCustomInteger25",
			"OptimizedCustomInteger4",
			"OptimizedCustomDateTime4",
			"OptimizedCustomTextSM46",
			"OptimizedCustomTextSM33",
			"OptimizedCustomPickList5",
			"OptimizedCustomNumber1",
			"OptimizedCustomDateTime20",
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
			"ObjectPlanName",
			"ObjectType",
			"ObjectStatus",
			"ObjectDescription",
			"ObjectExternalSystemId",
			"CreatedBy",
			"ModifiedBy"
		];
	}
}