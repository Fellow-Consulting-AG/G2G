// semi-automatically generated from CustomObject10.wsdl
package gadget.dao
{
	import flash.data.SQLConnection;

	public class CustomObject10DAO extends CustomeObjectBaseDao {

		public function CustomObject10DAO(sqlConnection:SQLConnection, work:Function) {
			super(work, sqlConnection, {
				table: 'sod_customobject10',
				oracle_id: 'Id',
				name_column: [ 'Name' ],
				search_columns: [ 'Name' ],
				display_name : "CustomObject10",	//___EDIT__THIS___
				index: [ 'Id' ],
				columns: { 'TEXT' : textColumns }
			});
		}

		override public function get entity():String {
			return "CustomObject10";
		}
		
		private var textColumns:Array = [
			"AccountExternalSystemId",
			"AccountId",
			"AccountIntegrationId",
			"AccountLocation",
			"AccountName",
			"AccountOwner",
			"AccountPriority",
			"AccountReference",
			"AccountType",
			"ActivityCallType",
			"ActivityExternalSystemId",
			"ActivityId",
			"ActivityIntegrationId",
			"ActivityStatus",
//			"ActivitySubject",
			"ServiceRequestNumber",
			"ActivityName",
			"AssetExternalSystemId",
			"AssetId",
			"AssetIntegrationId",
			"AssetProduct",
			"AssetSerialNumber",
			"CampaignExternalSystemId",
			"CampaignId",
			"CampaignIntegrationId",
			"CampaignName",
			"ContactAccountName",
			"ContactEmail",
			"ContactExternalSystemId",
			"ContactFirstName",
			"ContactFullName",
			"ContactId",
			"ContactIntegrationId",
			"ContactLastName",
			"CreatedBy",
			"CreatedByAlias",
			"CreatedByEMailAddr",
			"CreatedByExternalSystemId",
			"CreatedByFirstName",
			"CreatedByFullName",
			"CreatedById",
			"CreatedByIntegrationId",
			"CreatedByLastName",
			"CreatedByUserSignInId",
			"CreatedDate",
			"CurrencyCode",
			"CustomBoolean0",
			"CustomBoolean1",
			"CustomBoolean10",
			"CustomBoolean11",
			"CustomBoolean12",
			"CustomBoolean13",
			"CustomBoolean14",
			"CustomBoolean15",
			"CustomBoolean16",
			"CustomBoolean17",
			"CustomBoolean18",
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
			"CustomBoolean3",
			"CustomBoolean30",
			"CustomBoolean31",
			"CustomBoolean32",
			"CustomBoolean33",
			"CustomBoolean34",
			"CustomBoolean4",
			"CustomBoolean5",
			"CustomBoolean6",
			"CustomBoolean7",
			"CustomBoolean8",
			"CustomBoolean9",
			"CustomCurrency0",
			"CustomCurrency1",
			"CustomCurrency10",
			"CustomCurrency11",
			"CustomCurrency12",
			"CustomCurrency13",
			"CustomCurrency14",
			"CustomCurrency15",
			"CustomCurrency16",
			"CustomCurrency17",
			"CustomCurrency18",
			"CustomCurrency19",
			"CustomCurrency2",
			"CustomCurrency20",
			"CustomCurrency21",
			"CustomCurrency22",
			"CustomCurrency23",
			"CustomCurrency24",
			"CustomCurrency3",
			"CustomCurrency4",
			"CustomCurrency5",
			"CustomCurrency6",
			"CustomCurrency7",
			"CustomCurrency8",
			"CustomCurrency9",
			"CustomDate0",
			"CustomDate1",
			"CustomDate10",
			"CustomDate11",
			"CustomDate12",
			"CustomDate13",
			"CustomDate14",
			"CustomDate15",
			"CustomDate16",
			"CustomDate17",
			"CustomDate18",
			"CustomDate19",
			"CustomDate2",
			"CustomDate20",
			"CustomDate21",
			"CustomDate22",
			"CustomDate23",
			"CustomDate24",
			"CustomDate25",
			"CustomDate26",
			"CustomDate27",
			"CustomDate28",
			"CustomDate29",
			"CustomDate3",
			"CustomDate30",
			"CustomDate31",
			"CustomDate32",
			"CustomDate33",
			"CustomDate34",
			"CustomDate35",
			"CustomDate36",
			"CustomDate37",
			"CustomDate38",
			"CustomDate39",
			"CustomDate4",
			"CustomDate40",
			"CustomDate41",
			"CustomDate42",
			"CustomDate43",
			"CustomDate44",
			"CustomDate45",
			"CustomDate46",
			"CustomDate47",
			"CustomDate48",
			"CustomDate49",
			"CustomDate5",
			"CustomDate50",
			"CustomDate51",
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
			"CustomInteger0",
			"CustomInteger1",
			"CustomInteger10",
			"CustomInteger11",
			"CustomInteger12",
			"CustomInteger13",
			"CustomInteger14",
			"CustomInteger15",
			"CustomInteger16",
			"CustomInteger17",
			"CustomInteger18",
			"CustomInteger19",
			"CustomInteger2",
			"CustomInteger20",
			"CustomInteger21",
			"CustomInteger22",
			"CustomInteger23",
			"CustomInteger24",
			"CustomInteger25",
			"CustomInteger26",
			"CustomInteger27",
			"CustomInteger28",
			"CustomInteger29",
			"CustomInteger3",
			"CustomInteger30",
			"CustomInteger31",
			"CustomInteger32",
			"CustomInteger33",
			"CustomInteger34",
			"CustomInteger4",
			"CustomInteger5",
			"CustomInteger6",
			"CustomInteger7",
			"CustomInteger8",
			"CustomInteger9",
			"CustomNumber0",
			"CustomNumber1",
			"CustomNumber10",
			"CustomNumber11",
			"CustomNumber12",
			"CustomNumber13",
			"CustomNumber14",
			"CustomNumber15",
			"CustomNumber16",
			"CustomNumber17",
			"CustomNumber18",
			"CustomNumber19",
			"CustomNumber2",
			"CustomNumber20",
			"CustomNumber21",
			"CustomNumber22",
			"CustomNumber23",
			"CustomNumber24",
			"CustomNumber25",
			"CustomNumber26",
			"CustomNumber27",
			"CustomNumber28",
			"CustomNumber29",
			"CustomNumber3",
			"CustomNumber30",
			"CustomNumber31",
			"CustomNumber32",
			"CustomNumber33",
			"CustomNumber34",
			"CustomNumber35",
			"CustomNumber36",
			"CustomNumber37",
			"CustomNumber38",
			"CustomNumber39",
			"CustomNumber4",
			"CustomNumber40",
			"CustomNumber41",
			"CustomNumber42",
			"CustomNumber43",
			"CustomNumber44",
			"CustomNumber45",
			"CustomNumber46",
			"CustomNumber47",
			"CustomNumber48",
			"CustomNumber49",
			"CustomNumber5",
			"CustomNumber50",
			"CustomNumber51",
			"CustomNumber52",
			"CustomNumber53",
			"CustomNumber54",
			"CustomNumber55",
			"CustomNumber56",
			"CustomNumber57",
			"CustomNumber58",
			"CustomNumber59",
			"CustomNumber6",
			"CustomNumber60",
			"CustomNumber61",
			"CustomNumber62",
			"CustomNumber63",
			"CustomNumber64",
			"CustomNumber7",
			"CustomNumber8",
			"CustomNumber9",
			"CustomObject10ExternalSystemId",
			"CustomObject10Id",
			"CustomObject10IntegrationId",
			"CustomObject10Name",
			"CustomObject11ExternalSystemId",
			"CustomObject11Id",
			"CustomObject11IntegrationId",
			"CustomObject11Name",
			"CustomObject12ExternalSystemId",
			"CustomObject12Id",
			"CustomObject12IntegrationId",
			"CustomObject12Name",
			"CustomObject13ExternalSystemId",
			"CustomObject13Id",
			"CustomObject13IntegrationId",
			"CustomObject13Name",
			"CustomObject14ExternalSystemId",
			"CustomObject14Id",
			"CustomObject14IntegrationId",
			"CustomObject14Name",
			"CustomObject15ExternalSystemId",
			"CustomObject15Id",
			"CustomObject15IntegrationId",
			"CustomObject15Name",
			"CustomObject1ExternalSystemId",
			"CustomObject1Id",
			"CustomObject1IntegrationId",
			"CustomObject1Name",
			"CustomObject2ExternalSystemId",
			"CustomObject2Id",
			"CustomObject2IntegrationId",
			"CustomObject2Name",
			"CustomObject3ExternalSystemId",
			"CustomObject3Id",
			"CustomObject3IntegrationId",
			"CustomObject3Name",
			"CustomObject4ExternalSystemId",
			"CustomObject4Id",
			"CustomObject4IntegrationId",
			"CustomObject4Name",
			"CustomObject5ExternalSystemId",
			"CustomObject5Id",
			"CustomObject5IntegrationId",
			"CustomObject5Name",
			"CustomObject6ExternalSystemId",
			"CustomObject6Id",
			"CustomObject6IntegrationId",
			"CustomObject6Name",
			"CustomObject7ExternalSystemId",
			"CustomObject7Id",
			"CustomObject7IntegrationId",
			"CustomObject7Name",
			"CustomObject8ExternalSystemId",
			"CustomObject8Id",
			"CustomObject8IntegrationId",
			"CustomObject8Name",
			"CustomObject9ExternalSystemId",
			"CustomObject9Id",
			"CustomObject9IntegrationId",
			"CustomObject9Name",
			"CustomPhone0",
			"CustomPhone1",
			"CustomPhone10",
			"CustomPhone11",
			"CustomPhone12",
			"CustomPhone13",
			"CustomPhone14",
			"CustomPhone15",
			"CustomPhone16",
			"CustomPhone17",
			"CustomPhone18",
			"CustomPhone19",
			"CustomPhone2",
			"CustomPhone3",
			"CustomPhone4",
			"CustomPhone5",
			"CustomPhone6",
			"CustomPhone7",
			"CustomPhone8",
			"CustomPhone9",
			"CustomPickList0",
			"CustomPickList1",
			"CustomPickList10",
			"CustomPickList11",
			"CustomPickList12",
			"CustomPickList13",
			"CustomPickList14",
			"CustomPickList15",
			"CustomPickList16",
			"CustomPickList17",
			"CustomPickList18",
			"CustomPickList19",
			"CustomPickList2",
			"CustomPickList20",
			"CustomPickList21",
			"CustomPickList22",
			"CustomPickList23",
			"CustomPickList24",
			"CustomPickList25",
			"CustomPickList26",
			"CustomPickList27",
			"CustomPickList28",
			"CustomPickList29",
			"CustomPickList3",
			"CustomPickList30",
			"CustomPickList31",
			"CustomPickList32",
			"CustomPickList33",
			"CustomPickList34",
			"CustomPickList35",
			"CustomPickList36",
			"CustomPickList37",
			"CustomPickList38",
			"CustomPickList39",
			"CustomPickList4",
			"CustomPickList40",
			"CustomPickList41",
			"CustomPickList42",
			"CustomPickList43",
			"CustomPickList44",
			"CustomPickList45",
			"CustomPickList46",
			"CustomPickList47",
			"CustomPickList48",
			"CustomPickList49",
			"CustomPickList5",
			"CustomPickList50",
			"CustomPickList51",
			"CustomPickList52",
			"CustomPickList53",
			"CustomPickList54",
			"CustomPickList55",
			"CustomPickList56",
			"CustomPickList57",
			"CustomPickList58",
			"CustomPickList59",
			"CustomPickList6",
			"CustomPickList60",
			"CustomPickList61",
			"CustomPickList62",
			"CustomPickList63",
			"CustomPickList64",
			"CustomPickList65",
			"CustomPickList66",
			"CustomPickList67",
			"CustomPickList68",
			"CustomPickList69",
			"CustomPickList7",
			"CustomPickList70",
			"CustomPickList71",
			"CustomPickList72",
			"CustomPickList73",
			"CustomPickList74",
			"CustomPickList75",
			"CustomPickList76",
			"CustomPickList77",
			"CustomPickList78",
			"CustomPickList79",
			"CustomPickList8",
			"CustomPickList80",
			"CustomPickList81",
			"CustomPickList82",
			"CustomPickList83",
			"CustomPickList84",
			"CustomPickList85",
			"CustomPickList86",
			"CustomPickList87",
			"CustomPickList88",
			"CustomPickList89",
			"CustomPickList9",
			"CustomPickList90",
			"CustomPickList91",
			"CustomPickList92",
			"CustomPickList93",
			"CustomPickList94",
			"CustomPickList95",
			"CustomPickList96",
			"CustomPickList97",
			"CustomPickList98",
			"CustomPickList99",
			"CustomText0",
			"CustomText1",
			"CustomText10",
			"CustomText11",
			"CustomText12",
			"CustomText13",
			"CustomText14",
			"CustomText15",
			"CustomText16",
			"CustomText17",
			"CustomText18",
			"CustomText19",
			"CustomText2",
			"CustomText20",
			"CustomText21",
			"CustomText22",
			"CustomText23",
			"CustomText24",
			"CustomText25",
			"CustomText26",
			"CustomText27",
			"CustomText28",
			"CustomText29",
			"CustomText3",
			"CustomText30",
			"CustomText31",
			"CustomText32",
			"CustomText33",
			"CustomText34",
			"CustomText35",
			"CustomText36",
			"CustomText37",
			"CustomText38",
			"CustomText39",
			"CustomText4",
			"CustomText40",
			"CustomText41",
			"CustomText42",
			"CustomText43",
			"CustomText44",
			"CustomText45",
			"CustomText46",
			"CustomText47",
			"CustomText48",
			"CustomText49",
			"CustomText5",
			"CustomText50",
			"CustomText51",
			"CustomText52",
			"CustomText53",
			"CustomText54",
			"CustomText55",
			"CustomText56",
			"CustomText57",
			"CustomText58",
			"CustomText59",
			"CustomText6",
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
			"CustomText7",
			"CustomText70",
			"CustomText71",
			"CustomText72",
			"CustomText73",
			"CustomText74",
			"CustomText75",
			"CustomText76",
			"CustomText77",
			"CustomText78",
			"CustomText79",
			"CustomText8",
			"CustomText80",
			"CustomText81",
			"CustomText82",
			"CustomText83",
			"CustomText84",
			"CustomText85",
			"CustomText86",
			"CustomText87",
			"CustomText88",
			"CustomText89",
			"CustomText9",
			"DealRegistrationDealRegistrationName",
			"DealRegistrationExternalSystemId",
			"DealRegistrationId",
			"DealerExternalSystemId",
			"DealerId",
			"DealerIntegrationId",
			"DealerName",
			"Description",
			"ExchangeDate",
			"ExternalSystemId",
			"FundId",
			"FundName",
			"FundRequestExternalSystemId",
			"FundRequestId",
			"FundRequestName",
			"HouseholdExternalSystemId",
			"HouseholdId",
			"HouseholdIntegrationId",
			"HouseholdName",
			"Id",
			"IndexedBoolean0",
			"IndexedCurrency0",
			"IndexedDate0",
			"IndexedNumber0",
			"IndexedPick0",
			"IndexedPick1",
			"IndexedPick2",
			"IndexedPick3",
			"IndexedPick4",
			"IntegrationId",
			"LeadExternalSystemId",
			"LeadFirstName",
			"LeadFullName",
			"LeadId",
			"LeadIntegrationId",
			"LeadLastName",
/*
			"ListOfAccount",
			"ListOfActivity",
			"ListOfAsset",
			"ListOfBook",
			"ListOfCampaign",
			"ListOfContact",
			"ListOfCustomObject1",
			"ListOfCustomObject10Child",
			"ListOfCustomObject11",
			"ListOfCustomObject12",
			"ListOfCustomObject13",
			"ListOfCustomObject14",
			"ListOfCustomObject15",
			"ListOfCustomObject2",
			"ListOfCustomObject3",
			"ListOfCustomObject4",
			"ListOfCustomObject5",
			"ListOfCustomObject6",
			"ListOfCustomObject7",
			"ListOfCustomObject8",
			"ListOfCustomObject9",
			"ListOfDealRegistration",
			"ListOfDealer",
			"ListOfFund",
			"ListOfHousehold",
			"ListOfLead",
			"ListOfMDFRequest",
			"ListOfMedEd",
			"ListOfOpportunity",
			"ListOfPartner",
			"ListOfPortfolio",
			"ListOfProduct",
			"ListOfSPRequest",
			"ListOfServiceRequest",
			"ListOfSolution",
			"ListOfVehicle",
*/
			"MDFRequestExternalSystemId",
			"MDFRequestId",
			"MDFRequestIntegrationId",
			"MDFRequestRequestName",
			"MedEdExternalSystemId",
			"MedEdId",
			"MedEdIntegrationId",
			"MedEdName",
			"ModId",
			"ModifiedBy",
			"ModifiedById",
			"ModifiedDate",
			"Name",
			"OpportunityAccountName",
			"OpportunityCloseDate",
			"OpportunityExternalSystemId",
			"OpportunityForecast",
			"OpportunityId",
			"OpportunityIntegrationId",
			"OpportunityModifiedDateExt",
			"OpportunityName",
			"OpportunityOwner",
			"OpportunityRevenue",
			"OwnerAlias",
			"OwnerEMailAddr",
			"OwnerExternalSystemId",
			"OwnerFirstName",
			"OwnerFullName",
			"OwnerId",
			"OwnerIntegrationId",
			"OwnerLastName",
			"OwnerUserSignInId",
			"PartnerChannelAccountManagerAlias",
			"PartnerExternalSystemId",
			"PartnerId",
			"PartnerIntegrationId",
			"PartnerLocation",
			"PartnerName",
			"PortfolioAccountNumber",
			"PortfolioExternalSystemId",
			"PortfolioId",
			"PortfolioIntegrationId",
			"ProductCategory",
			"ProductDescription",
			"ProductExternalSystemId",
			"ProductId",
			"ProductIntegrationId",
			"ProductName",
			"ProductPartNumber",
			"ProductStatus",
			"ProductType",
			"ProgramId",
			"ProgramName",
			"QuickSearch1",
			"QuickSearch2",
			"SPRequestExternalSystemId",
			"SPRequestId",
			"SPRequestIntegrationId",
			"SPRequestSPRequestName",
			"ServiceRequestExternalSystemId",
			"ServiceRequestId",
			"ServiceRequestIntegrationId",
			"ServiceRequestSRNumber",
			"SolutionDistributionMethod",
			"SolutionExpirationDate",
			"SolutionExternalSystemId",
			"SolutionId",
			"SolutionIntegrationId",
			"SolutionLegalApproval",
			"SolutionMarketingApproval",
			"SolutionMultiFileAsset",
			"SolutionPCDAttachmentType",
			"SolutionReleaseDate",
			"SolutionStatus",
			"SolutionTitle",
			"SolutionVerificationStatus",
			"Type",
			"UpdatedByAlias",
			"UpdatedByEMailAddr",
			"UpdatedByExternalSystemId",
			"UpdatedByFirstName",
			"UpdatedByFullName",
			"UpdatedByIntegrationId",
			"UpdatedByLastName",
			"UpdatedByUserSignInId",
			"VehicleExternalSystemId",
			"VehicleId",
			"VehicleIntegrationId",
			"VehicleVIN",
			];
	}
}
