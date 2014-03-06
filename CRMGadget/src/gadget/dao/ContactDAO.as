package gadget.dao
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import gadget.util.FieldUtils;
	import gadget.util.Utils;
	
	import mx.collections.ArrayCollection;
	
	public class ContactDAO extends BaseDAO {
		
		private var stmtUpdateImage:SQLStatement;
		private var stmtUpdateFacebook:SQLStatement;
		private var stmtUpdateLinkedin:SQLStatement;
		private var stmtSelectContactById:SQLStatement;
		
		private var stmtContactAccount:SQLStatement;
		private var stmtContactOpportunity:SQLStatement;
		
		public function ContactDAO(sqlConnection:SQLConnection, work:Function) {
			super(work, sqlConnection,
				{
					table: 'contact',
					oracle_id: 'ContactId',
					name_column: ['ContactFirstName', 'ContactLastName'],
					search_columns: ['ContactLastName', 'ContactFirstName'],
					display_name : "contacts",
					index: ["AccountId", "ContactId", "UpperName", "Deleted", "OwnerId", "local_update"],
					columns: { 'TEXT' : textColumns }
				});
			
			stmtSelectContactById = new SQLStatement();
			stmtSelectContactById.sqlConnection = sqlConnection;
			stmtSelectContactById.text = "SELECT * FROM Contact WHERE ContactId=:ContactId";
			
			// statement for updating contact image
			stmtUpdateImage = new SQLStatement();
			stmtUpdateImage.sqlConnection = sqlConnection;
			stmtUpdateImage.text = "UPDATE contact SET picture = :data, local_update=:local_update WHERE gadget_id = :gadget_id";
			
			// update profile on facebook
			stmtUpdateFacebook = new SQLStatement();
			stmtUpdateFacebook.sqlConnection = sqlConnection;
			stmtUpdateFacebook.text = "UPDATE contact SET facebook = :facebook, local_update=:local_update WHERE gadget_id = :gadget_id";
			
			// update linkedin on facebook
			stmtUpdateLinkedin = new SQLStatement();
			stmtUpdateLinkedin.sqlConnection = sqlConnection;
			stmtUpdateLinkedin.text = "UPDATE contact SET linkedin = :linkedin, local_update=:local_update WHERE gadget_id = :gadget_id";

			stmtContactAccount = new SQLStatement();
			stmtContactAccount.sqlConnection = sqlConnection;
			stmtContactAccount.text = "SELECT 'Account' gadget_type, * FROM account WHERE AccountId in (SELECT AccountId FROM contact_account WHERE ( deleted = 0 OR deleted IS null ) AND ContactId = :contactId);";
			
			stmtContactOpportunity = new SQLStatement();
			stmtContactOpportunity.sqlConnection = sqlConnection;
			stmtContactOpportunity.text = "SELECT 'Opportunity' gadget_type, dest.* FROM opportunity dest  WHERE dest.KeyContactId = :contactId AND (dest.deleted = 0 OR dest.deleted IS null) UNION SELECT 'Opportunity' gadget_type, src.* FROM opportunity src, Opportunity_ContactRole supp, contact dest  WHERE dest.ContactId = supp.ContactId AND src.OpportunityId = supp.OpportunityId AND dest.gadget_id = :gadget_id AND (supp.deleted = 0 OR supp.deleted IS null) AND (src.deleted = 0 OR src.deleted IS null) ORDER BY OpportunityName";
		}
/*
		override protected function get sortColumn():String {
			return "contactlastname";
		}
*/		
		public function getContactOpportnity(contactId:String, gadgetId:String):ArrayCollection{
			stmtContactOpportunity.parameters[":contactId"] = contactId;
			stmtContactOpportunity.parameters[":gadget_id"] = gadgetId;
			exec(stmtContactOpportunity);
			var result:SQLResult = stmtContactOpportunity.getResult();
			return new ArrayCollection(result.data);
		}
		
		public function getContactAccount(contactId:String):ArrayCollection{
			stmtContactAccount.parameters[":contactId"] = contactId;
			exec(stmtContactAccount);
			var result:SQLResult = stmtContactAccount.getResult();
			return new ArrayCollection(result.data);
		}
		override public function get entity():String {
			return "Contact";
		}
		
		public function updateFacebook(contact:Object):void {
			stmtUpdateFacebook.parameters[":facebook"] = contact.facebook;
			stmtUpdateFacebook.parameters[":local_update"] = new Date().getTime();
			stmtUpdateFacebook.parameters[':gadget_id'] = contact.gadget_id;
			exec(stmtUpdateFacebook);
		}
		
		public function updateLinkedin(contact:Object):void {
			stmtUpdateLinkedin.parameters[":linkedin"] = contact.linkedin;
			stmtUpdateLinkedin.parameters[":local_update"] = new Date().getTime();
			stmtUpdateLinkedin.parameters[':gadget_id'] = contact.gadget_id;
			exec(stmtUpdateLinkedin);
		}
		
		public function getContactById(contactId:String):Object {
			stmtSelectContactById.parameters[":ContactId"] = contactId;
			exec(stmtSelectContactById);
			var result:SQLResult = stmtSelectContactById.getResult();
			if (result.data == null || result.data.length == 0) {
				return null;
			}
			return result.data[0];
		}
		
		public function updateImage(data:ByteArray, contact:Object):void {
			contact.picture = data;
			stmtUpdateImage.parameters[":local_update"] = new Date().getTime();
			stmtUpdateImage.parameters[':data'] = data;
			stmtUpdateImage.parameters[':gadget_id'] = contact.gadget_id;
			exec(stmtUpdateImage);
		}
	
		override protected function getOutgoingIgnoreFields():ArrayCollection{
			return INGNORE_FIELDS;
		}
		
		override protected function getIncomingIgnoreFields():ArrayCollection{
			return INCOMING_INGNORE_FIELDS;
		}
		
		private static const INCOMING_INGNORE_FIELDS:ArrayCollection=new ArrayCollection(
			[
				"ms_id",
				"ms_change_key",
				"facebook",
				"linkedin"
			]);
		private static const INGNORE_FIELDS:ArrayCollection=new ArrayCollection(
				[
					"AccountLocation",
					"AccountExternalSystemId",
					"AccountFuriganaName",
					"AccountName",
					"AlternateAddressExternalSystemId",
					"ManagerExternalSystemId",
					"CustomObject1ExternalSystemId",
					"CustomObject2ExternalSystemId",
					"CustomObject3ExternalSystemId",
					"CustomObject2Name",
					"CustomObject1Name",
					"CustomObject3Name",
					"PrimaryCity", 
					"PrimaryCountry", 
					"PrimaryAddress", 
					"PrimaryZipCode",
					"Manager",
					"SourceCampaignName",
					"ms_id",
					"ms_change_key",
					"facebook",
					"linkedin"
				]);
		private var textColumns:Array = [
			"AccountExternalSystemId", 
			"AccountFuriganaName", 
			"AccountId", 
			"AccountLocation", 
			"AccountName", 
			"Age", 
			"AlternateAddress1",
			"AlternateAddress2", 
			"AlternateAddress3", 
			"AlternateAddressExternalSystemId", 
			"AlternateAddressId", 
			"AlternateCity", 
			"AlternateCountry", 
			"AlternateCounty", 
			"AlternateProvince", 
			"AlternateStateProvince", 
			"AlternateZipCode",
			"AssessmentFilter1", 
			"AssessmentFilter2", 
			"AssessmentFilter3", 
			"AssessmentFilter4", 
			"AssistantName", 
			"AssistantPhone", 
			"BestTimeToCall", 
			"BuyingRole", 
			"CallFrequency", 
			"CellularPhone",
			"ContactConcatField", 
			"ContactEmail", 
			"ContactFirstName", 
			"ContactFullName", 
			"ContactId", 
			"ContactLastName", 
			"ContactRole", 
			"ContactType", 
			"CreatedBy", 
			"CreatedById",
			"CreatedDate", 
			"CreatedbyEmailAddress", 
			"CreditScore", 
			"CurrencyCode", 
			"CurrentInvestmentMix", 
			"DateofBirth", 
			"Degree", 
			"Department", 
			"Description", 
			"ExperienceLevel",
			"ExternalSystemId", 
			"FuriganaFirstName", 
			"FuriganaLastName", 
			"Gender", 
			"HomePhone", 
			"HomeValue", 
			"IntegrationId", 
			"InvestmentHorizon", 
			"JobTitle", 
			"LastActivityDate",
			"LastAssessmentDate", 
			"LastCallDate", 
			"LastUpdated", 
			"LeadSource", 
			"LifeEvent", 
			"Manager", 
			"ManagerExternalSystemId", 
			"ManagerId", 
			"MaritalStatus", 
			"MarketPotential",
			"MiddleName", 
			"ModId", 
			"ModifiedBy", 
			"ModifiedById", 
			"ModifiedDate", 
			"ModifiedbyEmailAddress", 
			"MrMrs", 
			"NeverEmail", 
			"Objective", 
			"OccamTerritory",
			"OptIn", 
			"OptOut", 
			"Owner", 
			"OwnerEmailAddress", 
			"OwnerExternalSystemId", 
			"OwnerFullName", 
			"OwnerId", 
			"OwnorRent", 
			"PIMCompanyName", 
			"PrimaryAddress",
			"PrimaryAddressId", 
			"PrimaryCity", 
			"PrimaryCountry", 
			"PrimaryCounty", 
			"PrimaryGoal", 
			"PrimaryGroup", 
			"PrimaryProvince", 
			"PrimaryStateProvince", 
			"PrimaryStreetAddress2", 
			"PrimaryStreetAddress3",
			"PrimaryZipCode", 
			"Private", 
			"RiskProfile", 
			"Route", 
			"Segment", 
			"SelfEmployed", 
			"SourceCampaignId", 
			"SourceCampaignName", 
			"TaxBracket", 
			"TerritoryId",
			"Tier", 
			"TimeZoneName", 
			"TotalAssets", 
			"TotalExpenses", 
			"TotalIncome", 
			"TotalLiabilities", 
			"TotalNetWorth", 
			"WorkFax", 
			"WorkPhone", 
			"YTDSales",
			"CustomBoolean0", 
			"CustomBoolean1", 
			"CustomBoolean2", 
			"CustomBoolean3", 
			"CustomBoolean4", 
			"CustomBoolean5", 
			"CustomBoolean6", 
			"CustomBoolean7", 
			"CustomBoolean8", 
			"CustomBoolean9",
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
			"CustomBoolean30", 
			"CustomBoolean31", 
			"CustomBoolean32", 
			"CustomBoolean33", 
			"CustomBoolean34", 
			"CustomCurrency0", 
			"CustomCurrency1", 
			"CustomCurrency2", 
			"CustomCurrency3", 
			"CustomCurrency4",
			"CustomCurrency5", 
			"CustomCurrency6", 
			"CustomCurrency7", 
			"CustomCurrency8", 
			"CustomCurrency9", 
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
			"CustomCurrency20", 
			"CustomCurrency21", 
			"CustomCurrency22", 
			"CustomCurrency23", 
			"CustomCurrency24",
			"CustomDate0", 
			"CustomDate1", 
			"CustomDate2", 
			"CustomDate3", 
			"CustomDate4", 
			"CustomDate5", 
			"CustomDate6", 
			"CustomDate7", 
			"CustomDate8", 
			"CustomDate9",
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
			"CustomInteger0", 
			"CustomInteger1", 
			"CustomInteger2", 
			"CustomInteger3", 
			"CustomInteger4", 
			"CustomInteger5", 
			"CustomInteger6", 
			"CustomInteger7", 
			"CustomInteger8", 
			"CustomInteger9",
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
			"CustomInteger30", 
			"CustomInteger31", 
			"CustomInteger32", 
			"CustomInteger33", 
			"CustomInteger34", 
			"CustomMultiSelectPickList0", 
			"CustomMultiSelectPickList1", 
			"CustomMultiSelectPickList2", 
			"CustomMultiSelectPickList3", 
			"CustomMultiSelectPickList4",
			"CustomMultiSelectPickList5", 
			"CustomMultiSelectPickList6", 
			"CustomMultiSelectPickList7", 
			"CustomMultiSelectPickList8", 
			"CustomMultiSelectPickList9", 
			"CustomNumber0", 
			"CustomNumber1", 
			"CustomNumber2", 
			"CustomNumber3", 
			"CustomNumber4",
			"CustomNumber5", 
			"CustomNumber6", 
			"CustomNumber7", 
			"CustomNumber8", 
			"CustomNumber9", 
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
			"CustomNumber60", 
			"CustomNumber61", 
			"CustomNumber62", 
			"CustomObject1ExternalSystemId", 
			"CustomObject1Id",
			"CustomObject1Name", 
			"CustomObject2ExternalSystemId", 
			"CustomObject2Id", 
			"CustomObject2Name", 
			"CustomObject3ExternalSystemId", 
			"CustomObject3Id", 
			"CustomObject3Name", 
			'CustomObject4Id',
			'CustomObject4Name',
			'CustomObject5Id',
			'CustomObject5Name',
			'CustomObject6Id',
			'CustomObject6Name',
			'CustomObject7Id',
			'CustomObject7Name',
			'CustomObject8Id',
			'CustomObject8Name',
			'CustomObject9Id',
			'CustomObject9Name',
			'CustomObject10Id',
			'CustomObject10Name',
			'CustomObject11Id',
			'CustomObject11Name',
			'CustomObject12Id',
			'CustomObject12Name',
			'CustomObject13Id',
			'CustomObject13Name',
			'CustomObject14Id',
			'CustomObject14Name',
			'CustomObject15Id',
			'CustomObject15Name',
			"CustomPhone0", 
			"CustomPhone1", 
			"CustomPhone2",
			"CustomPhone3", 
			"CustomPhone4", 
			"CustomPhone5", 
			"CustomPhone6", 
			"CustomPhone7", 
			"CustomPhone8", 
			"CustomPhone9", 
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
			"CustomPickList0", 
			"CustomPickList1", 
			"CustomPickList2",
			"CustomPickList3", 
			"CustomPickList4", 
			"CustomPickList5", 
			"CustomPickList6", 
			"CustomPickList7", 
			"CustomPickList8", 
			"CustomPickList9", 
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
			"CustomText2",
			"CustomText3", 
			"CustomText4", 
			"CustomText5", 
			"CustomText6", 
			"CustomText7", 
			"CustomText8", 
			"CustomText9", 
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
			"CustomText90", 
			"CustomText91", 
			"CustomText92",
			"CustomText93", 
			"CustomText94", 
			"CustomText95", 
			"CustomText96", 
			"CustomText97", 
			"CustomText98", 
			"CustomText99", 
			"CustomerId", 
			"IndexedBoolean0", 
			"IndexedCurrency0",
			"IndexedDate0", 
			"IndexedLongText0", 
			"IndexedNumber0", 
			"IndexedPick0", 
			"IndexedPick1", 
			"IndexedPick2", 
			"IndexedPick3", 
			"IndexedPick4", 
			"IndexedPick5", 
			"IndexedShortText0",
			"IndexedShortText1",
			"facebook",
			"linkedin",
			"ClientStatus"
		];
	}
}