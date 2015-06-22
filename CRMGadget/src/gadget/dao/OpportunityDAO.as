package gadget.dao
{
	import com.adobe.protocols.dict.Dict;
	import com.adobe.utils.DateUtil;
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.utils.Dictionary;
	
	import flex.lang.reflect.Field;
	
	import gadget.service.UserService;
	import gadget.util.DateUtils;
	import gadget.util.StringUtils;
	import gadget.util.Utils;
	
	import mx.collections.ArrayCollection;
	
	public class OpportunityDAO extends BaseDAO {
		
		
		public function OpportunityDAO(sqlConnection:SQLConnection, work:Function) {			
			super(work, sqlConnection, {
				table: 'opportunity',
				oracle_id: 'OpportunityId',
				name_column: [ 'OpportunityName' ],
				search_columns: [ 'OpportunityName' ],
				display_name : "opportunitys",
				index: [ "OpportunityId", "OpportunityType", "OwnerId", "AccountId" ],
				columns: { 'TEXT' : textColumns }
			});
		}
/*		
		override protected function get sortColumn():String {
			return "opportunityname";
		}
*/		
		override public function get entity():String {
			return "Opportunity";
		}
		
		
		override public function getIgnoreCopyFields():ArrayCollection{
			return new ArrayCollection(
					[
					'SalesStage',
					'SalesStageId',
					'CloseDate',
					'OpportunityId',
					'gadget_id',
					'local_update',
					'delete',
					'error',
					'ood_lastmodified',
					'sync_number',
					'important',
					'favorite'
					]);
		}
		
		
		override protected function getOutgoingIgnoreFields():ArrayCollection{
			return INGNORE_FIELDS;
		}
		
		
		private static const INGNORE_FIELDS:ArrayCollection=new ArrayCollection(
			[
				"AccountLocation",
				"AccountExternalSystemId",
				"AccountName",
				"CustomObject1ExternalSystemId",
				"CustomObject1Name",
				"CustomObject2ExternalSystemId",
				"CustomObject2Name",
				"CustomObject3ExternalSystemId",
				"CustomObject3Name",
				"CustomObject5ExternalSystemId",
				"CustomObject5Name",
				"CustomObject6ExternalSystemId",
				"CustomObject6Name"
			
			]);
		
		public static const MONTH_FIELD_FOR_EACH_Q:Array=[
			"CustomCurrency0",//Monthly Revenue 1
			"CustomCurrency2",//Monthly Revenue 2
			"CustomCurrency1",//Monthly Revenue 3
		];
		
		private var textColumns:Array = [
			'AccountExternalSystemId',
			'AccountId',
			'AccountLocation',
			'AccountName',
			'ApprovalStatus',
			'ApprovedDRExpiresDate',
			'ApprovedDRId',
			'ApprovedDRPartnerId',
			'ApprovedDRPartnerLocation',
			'ApprovedDRPartnerName',
			'ApproverAlias',
			'AssessmentFilter1',
			'AssessmentFilter2',
			'AssessmentFilter3',
			'AssessmentFilter4',
			'AssignmentStatus',
			'ChannelAccountManager',
			'CloseDate',
			'CreatedBy',
			'CreatedByEmailAddress',
			'CreatedById',
			'CreatedDate',
			'CurrencyCode',
			'Dealer',
			'DealerExternalSystemId',
			'DealerId',
			'Description',
			'ExpectedRevenue',
			'ExternalSystemId',
			'Forecast',
			'FuriganaAccountName',
			'IntegrationId',
			'KeyContactExternalSystemId',
			'KeyContactId',
			'KeyContactLastName',
			'LastAssessmentDate',
			'LastAssignmentCompletionDate',
			'LastAssignmentSubmissionDate',
			'LastUpdated',
			'LeadSource',
			'Make',
			'ModId',
			'Model',
			'ModifiedBy',
			'ModifiedByEmailAddress',
			'ModifiedById',
			'ModifiedDate',
			'NextStep',
			'OpportunityConcatField',
			'OpportunityId',
			'OpportunityName',
			'OpportunityType',
			'OriginatingPartnerExternalSystemId',
			'OriginatingPartnerIntegrationId',
			'OriginatingPartnerLocation',
			'OriginatingPartnerName',
			'Owner',
			'OwnerFullName',
			'OwnerId',
			'OwnerPartnerAccount',
			'OwnerPartnerExternalSystemId',
			'OwnerPartnerIntegrationId',
			'OwnerPartnerLocation',
			'OwnerPartnerName',
			'OwnershipStatus',
			'PrimaryGroup',
			'PrincipalPartnerExternalSystemId',
			'PrincipalPartnerIntegrationId',
			'PrincipalPartnerLocation',
			'PrincipalPartnerName',
			'Priority',
			'Probability',
			'ProductInterest',
			'ProgramProgramName',
			'ReasonWonLost',
			'ReassignOwnerFlag',
			'RegistrationStatus',
			'Revenue',
			'SalesProcess',
			'SalesProcessId',
			'SalesStage',
			'SalesStageId',
			'SourceCampaign',
			'SourceCampaignExternalSystemId',
			'SourceCampaignId',
			'StageStatus',
			'Status',
			'Territory',
			'TerritoryId',
			'TotalAssetValue',
			'TotalPremium',
			'Type',
			'Year',
			'CustomBoolean0',
			'CustomBoolean1',
			'CustomBoolean2',
			'CustomBoolean3',
			'CustomBoolean4',
			'CustomBoolean5',
			'CustomBoolean6',
			'CustomBoolean7',
			'CustomBoolean8',
			'CustomBoolean9',
			'CustomBoolean10',
			'CustomBoolean11',
			'CustomBoolean12',
			'CustomBoolean13',
			'CustomBoolean14',
			'CustomBoolean15',
			'CustomBoolean16',
			'CustomBoolean17',
			'CustomBoolean18',
			'CustomBoolean19',
			'CustomBoolean20',
			'CustomBoolean21',
			'CustomBoolean22',
			'CustomBoolean23',
			'CustomBoolean24',
			'CustomBoolean25',
			'CustomBoolean26',
			'CustomBoolean27',
			'CustomBoolean28',
			'CustomBoolean29',
			'CustomBoolean30',
			'CustomBoolean31',
			'CustomBoolean32',
			'CustomBoolean33',
			'CustomBoolean34',
			'CustomCurrency0',
			'CustomCurrency1',
			'CustomCurrency2',
			'CustomCurrency3',
			'CustomCurrency4',
			'CustomCurrency5',
			'CustomCurrency6',
			'CustomCurrency7',
			'CustomCurrency8',
			'CustomCurrency9',
			'CustomCurrency10',
			'CustomCurrency11',
			'CustomCurrency12',
			'CustomCurrency13',
			'CustomCurrency14',
			'CustomCurrency15',
			'CustomCurrency16',
			'CustomCurrency17',
			'CustomCurrency18',
			'CustomCurrency19',
			'CustomCurrency20',
			'CustomCurrency21',
			'CustomCurrency22',
			'CustomCurrency23',
			'CustomCurrency24',
			'CustomDate0',
			'CustomDate1',
			'CustomDate2',
			'CustomDate3',
			'CustomDate4',
			'CustomDate5',
			'CustomDate6',
			'CustomDate7',
			'CustomDate8',
			'CustomDate9',
			'CustomDate10',
			'CustomDate11',
			'CustomDate12',
			'CustomDate13',
			'CustomDate14',
			'CustomDate15',
			'CustomDate16',
			'CustomDate17',
			'CustomDate18',
			'CustomDate19',
			'CustomDate20',
			'CustomDate21',
			'CustomDate22',
			'CustomDate23',
			'CustomDate24',
			'CustomDate25',
			'CustomDate26',
			'CustomDate27',
			'CustomDate28',
			'CustomDate29',
			'CustomDate30',
			'CustomDate31',
			'CustomDate32',
			'CustomDate33',
			'CustomDate34',
			'CustomDate35',
			'CustomDate36',
			'CustomDate37',
			'CustomDate38',
			'CustomDate39',
			'CustomDate40',
			'CustomDate41',
			'CustomDate42',
			'CustomDate43',
			'CustomDate44',
			'CustomDate45',
			'CustomDate46',
			'CustomDate47',
			'CustomDate48',
			'CustomDate49',
			'CustomDate50',
			'CustomDate51',
			'CustomDate52',
			'CustomDate53',
			'CustomDate54',
			'CustomDate55',
			'CustomDate56',
			'CustomDate57',
			'CustomDate58',
			'CustomDate59',
			'CustomInteger0',
			'CustomInteger1',
			'CustomInteger2',
			'CustomInteger3',
			'CustomInteger4',
			'CustomInteger5',
			'CustomInteger6',
			'CustomInteger7',
			'CustomInteger8',
			'CustomInteger9',
			'CustomInteger10',
			'CustomInteger11',
			'CustomInteger12',
			'CustomInteger13',
			'CustomInteger14',
			'CustomInteger15',
			'CustomInteger16',
			'CustomInteger17',
			'CustomInteger18',
			'CustomInteger19',
			'CustomInteger20',
			'CustomInteger21',
			'CustomInteger22',
			'CustomInteger23',
			'CustomInteger24',
			'CustomInteger25',
			'CustomInteger26',
			'CustomInteger27',
			'CustomInteger28',
			'CustomInteger29',
			'CustomInteger30',
			'CustomInteger31',
			'CustomInteger32',
			'CustomInteger33',
			'CustomInteger34',
			'CustomMultiSelectPickList0',
			'CustomMultiSelectPickList1',
			'CustomMultiSelectPickList2',
			'CustomMultiSelectPickList3',
			'CustomMultiSelectPickList4',
			'CustomMultiSelectPickList5',
			'CustomMultiSelectPickList6',
			'CustomMultiSelectPickList7',
			'CustomMultiSelectPickList8',
			'CustomMultiSelectPickList9',
			'CustomNumber0',
			'CustomNumber1',
			'CustomNumber2',
			'CustomNumber3',
			'CustomNumber4',
			'CustomNumber5',
			'CustomNumber6',
			'CustomNumber7',
			'CustomNumber8',
			'CustomNumber9',
			'CustomNumber10',
			'CustomNumber11',
			'CustomNumber12',
			'CustomNumber13',
			'CustomNumber14',
			'CustomNumber15',
			'CustomNumber16',
			'CustomNumber17',
			'CustomNumber18',
			'CustomNumber19',
			'CustomNumber20',
			'CustomNumber21',
			'CustomNumber22',
			'CustomNumber23',
			'CustomNumber24',
			'CustomNumber25',
			'CustomNumber26',
			'CustomNumber27',
			'CustomNumber28',
			'CustomNumber29',
			'CustomNumber30',
			'CustomNumber31',
			'CustomNumber32',
			'CustomNumber33',
			'CustomNumber34',
			'CustomNumber35',
			'CustomNumber36',
			'CustomNumber37',
			'CustomNumber38',
			'CustomNumber39',
			'CustomNumber40',
			'CustomNumber41',
			'CustomNumber42',
			'CustomNumber43',
			'CustomNumber44',
			'CustomNumber45',
			'CustomNumber46',
			'CustomNumber47',
			'CustomNumber48',
			'CustomNumber49',
			'CustomNumber50',
			'CustomNumber51',
			'CustomNumber52',
			'CustomNumber53',
			'CustomNumber54',
			'CustomNumber55',
			'CustomNumber56',
			'CustomNumber57',
			'CustomNumber58',
			'CustomNumber59',
			'CustomNumber60',
			'CustomNumber61',
			'CustomNumber62',
			'CustomObject1ExternalSystemId',
			'CustomObject1Id',
			'CustomObject1Name',
			'CustomObject2ExternalSystemId',
			'CustomObject2Id',
			'CustomObject2Name',
			'CustomObject3ExternalSystemId',
			'CustomObject3Id',
			'CustomObject3Name',
			'CustomObject5ExternalSystemId',
			'CustomObject5Id',
			'CustomObject5Name',
			'CustomObject6ExternalSystemId',
			'CustomObject6Id',
			'CustomObject6Name',
			'CustomObject4Id',
			'CustomObject4Name',
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
			'CustomPhone0',
			'CustomPhone1',
			'CustomPhone2',
			'CustomPhone3',
			'CustomPhone4',
			'CustomPhone5',
			'CustomPhone6',
			'CustomPhone7',
			'CustomPhone8',
			'CustomPhone9',
			'CustomPhone10',
			'CustomPhone11',
			'CustomPhone12',
			'CustomPhone13',
			'CustomPhone14',
			'CustomPhone15',
			'CustomPhone16',
			'CustomPhone17',
			'CustomPhone18',
			'CustomPhone19',
			'CustomPickList0',
			'CustomPickList1',
			'CustomPickList2',
			'CustomPickList3',
			'CustomPickList4',
			'CustomPickList5',
			'CustomPickList6',
			'CustomPickList7',
			'CustomPickList8',
			'CustomPickList9',
			'CustomPickList10',
			'CustomPickList11',
			'CustomPickList12',
			'CustomPickList13',
			'CustomPickList14',
			'CustomPickList15',
			'CustomPickList16',
			'CustomPickList17',
			'CustomPickList18',
			'CustomPickList19',
			'CustomPickList20',
			'CustomPickList21',
			'CustomPickList22',
			'CustomPickList23',
			'CustomPickList24',
			'CustomPickList25',
			'CustomPickList26',
			'CustomPickList27',
			'CustomPickList28',
			'CustomPickList29',
			'CustomPickList30',
			'CustomPickList31',
			'CustomPickList32',
			'CustomPickList33',
			'CustomPickList34',
			'CustomPickList35',
			'CustomPickList36',
			'CustomPickList37',
			'CustomPickList38',
			'CustomPickList39',
			'CustomPickList40',
			'CustomPickList41',
			'CustomPickList42',
			'CustomPickList43',
			'CustomPickList44',
			'CustomPickList45',
			'CustomPickList46',
			'CustomPickList47',
			'CustomPickList48',
			'CustomPickList49',
			'CustomPickList50',
			'CustomPickList51',
			'CustomPickList52',
			'CustomPickList53',
			'CustomPickList54',
			'CustomPickList55',
			'CustomPickList56',
			'CustomPickList57',
			'CustomPickList58',
			'CustomPickList59',
			'CustomPickList60',
			'CustomPickList61',
			'CustomPickList62',
			'CustomPickList63',
			'CustomPickList64',
			'CustomPickList65',
			'CustomPickList66',
			'CustomPickList67',
			'CustomPickList68',
			'CustomPickList69',
			'CustomPickList70',
			'CustomPickList71',
			'CustomPickList72',
			'CustomPickList73',
			'CustomPickList74',
			'CustomPickList75',
			'CustomPickList76',
			'CustomPickList77',
			'CustomPickList78',
			'CustomPickList79',
			'CustomPickList80',
			'CustomPickList81',
			'CustomPickList82',
			'CustomPickList83',
			'CustomPickList84',
			'CustomPickList85',
			'CustomPickList86',
			'CustomPickList87',
			'CustomPickList88',
			'CustomPickList89',
			'CustomPickList90',
			'CustomPickList91',
			'CustomPickList92',
			'CustomPickList93',
			'CustomPickList94',
			'CustomPickList95',
			'CustomPickList96',
			'CustomPickList97',
			'CustomPickList98',
			'CustomPickList99',
			'CustomText0',
			'CustomText1',
			'CustomText2',
			'CustomText3',
			'CustomText4',
			'CustomText5',
			'CustomText6',
			'CustomText7',
			'CustomText8',
			'CustomText9',
			'CustomText10',
			'CustomText11',
			'CustomText12',
			'CustomText13',
			'CustomText14',
			'CustomText15',
			'CustomText16',
			'CustomText17',
			'CustomText18',
			'CustomText19',
			'CustomText20',
			'CustomText21',
			'CustomText22',
			'CustomText23',
			'CustomText24',
			'CustomText25',
			'CustomText26',
			'CustomText27',
			'CustomText28',
			'CustomText29',
			'CustomText30',
			'CustomText31',
			'CustomText32',
			'CustomText33',
			'CustomText34',
			'CustomText35',
			'CustomText36',
			'CustomText37',
			'CustomText38',
			'CustomText39',
			'CustomText40',
			'CustomText41',
			'CustomText42',
			'CustomText43',
			'CustomText44',
			'CustomText45',
			'CustomText46',
			'CustomText47',
			'CustomText48',
			'CustomText49',
			'CustomText50',
			'CustomText51',
			'CustomText52',
			'CustomText53',
			'CustomText54',
			'CustomText55',
			'CustomText56',
			'CustomText57',
			'CustomText58',
			'CustomText59',
			'CustomText60',
			'CustomText61',
			'CustomText62',
			'CustomText63',
			'CustomText64',
			'CustomText65',
			'CustomText66',
			'CustomText67',
			'CustomText68',
			'CustomText69',
			'CustomText70',
			'CustomText71',
			'CustomText72',
			'CustomText73',
			'CustomText74',
			'CustomText75',
			'CustomText76',
			'CustomText77',
			'CustomText78',
			'CustomText79',
			'CustomText80',
			'CustomText81',
			'CustomText82',
			'CustomText83',
			'CustomText84',
			'CustomText85',
			'CustomText86',
			'CustomText87',
			'CustomText88',
			'CustomText89',
			'CustomText90',
			'CustomText91',
			'CustomText92',
			'CustomText93',
			'CustomText94',
			'CustomText95',
			'CustomText96',
			'CustomText97',
			'CustomText98',
			'CustomText99',
			'IndexedBoolean0',
			'IndexedCurrency0',
			'IndexedDate0',
			'IndexedLongText0',
			'IndexedNumber0',
			'IndexedPick0',
			'IndexedPick1',
			'IndexedPick2',
			'IndexedPick3',
			'IndexedPick4',
			'IndexedPick5',
			'IndexedShortText0',
			'IndexedShortText1'
		];
		protected static const MAP_MONTH:Object = {
			'11':{min:9,max:11},
			'10':{min:9,max:11},
			'9':{min:9,max:11},
			'8':{min:6,max:8},
			'7':{min:6,max:8},
			'6':{min:6,max:8},
			'5':{min:3,max:5},
			'4':{min:3,max:5},
			'3':{min:3,max:5},
			'2':{min:0,max:2},
			'1':{min:0,max:2},
			'0':{min:0,max:2}		
		
		};
		public function findImpactCalendar(opColumns:Array,co7Field:Array):ArrayCollection {
			if(UserService.getCustomerId()==UserService.COLOPLAST){//should be work for coloplast only
				var cols:String = '';
				for each (var column:String in opColumns) {
					cols += ", o." + column;
				}
				for each (var co7f:String in co7Field) {
					cols += ", co." + co7f;
				}
				
				stmtFindAllWithCO7.text = "SELECT '" + entity + "' gadget_type " +cols +",o.gadget_id,co.gadget_id as co7_gadget_id,co.Id as co7_Id FROM " + tableName + "  o LEFT OUTER JOIN sod_customobject7  co ON o.OpportunityId = co.OpportunityId WHERE  (o.deleted = 0 OR o.deleted IS null)AND (co.deleted = 0 OR co.deleted IS null) order by o.OpportunityId,co.gadget_id, co.CustomPickList31,co.CustomPickList33";
				exec(stmtFindAllWithCO7);
				var result:SQLResult = stmtFindAllWithCO7.getResult();
				var data:Array = result.data;
				if (data != null && data.length>0) {
					return plate2Row(data,getCompititor(),getCallExpensesForCurrentQuater());
				}
			}
			return new ArrayCollection();
		}
		
		protected function getCompititor():Dictionary{
			var map:Dictionary = new Dictionary();
			var result:ArrayCollection = Database.opportunityCompetitorDao.findAll(new ArrayCollection([{element_name:'OpportunityId,CompetitorName,RelationshipRole,ReverseRelationshipRole'}]),null,null,0);
			if(result!=null){
				for each(var obj:Object in result){
					//opportunity has only one compititor
					obj.membershipgroup = obj.RelationshipRole=='Membership Group' || obj.ReverseRelationshipRole=='Membership Group';
					obj.distributor=obj.RelationshipRole=='Distributor' || obj.ReverseRelationshipRole=='Distributor';
					map[obj.OpportunityId]=obj;
				}

			}
			
			
			return map;
		}
		
		
		
		protected function getCallExpensesForCurrentQuater():Dictionary{
			var today:Date = new Date();
			
			//quater cannot null
			var q:Object = MAP_MONTH[today.month.toFixed()];
			var minDate:Date = new Date(today.fullYear,q.min,1);//min date of the mon
			var maxDate:Date = new Date(today.fullYear,q.max+1,0);//get max date of the month
			
			var paramStartDate:String = DateUtils.format(minDate,DateUtils.DATABASE_DATE_FORMAT);
			var paramEndDate:String = DateUtils.format(maxDate,DateUtils.DATABASE_DATE_FORMAT);
			
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = this.sqlConnection;
			var dateFilter:String = "(CompletedDatetime >= '" + paramStartDate + "T00:00:00Z'" +
				" AND CompletedDatetime<= '" + paramEndDate + "T23:59:59Z')";
			stmt.text = "select AccountId,Type,count(accountid) NumCall, sum(CustomCurrency0) Expenses  from activity WHERE CallType='Account Call' and Status='Completed' AND Activity = 'Appointment' AND "+dateFilter+"  group by accountid";
			exec(stmt);
			var items:ArrayCollection = new ArrayCollection(stmt.getResult().data);
			var result:Dictionary = new Dictionary();
			for each(var obj:Object in items){
				result[obj.AccountId]=obj;	
			}
			return result;
			
		}
		
		private function setCompititor(row:Object,compititor:Object):void{
			if(compititor!=null){
				if(compititor.membershipgroup){
					row.Membership = compititor.CompetitorName;
				}
				if(compititor.distributor){
					row.TradingPartner = compititor.CompetitorName;
				}
			}
		}
		
		private function setCallAndExpenses(row:Object,call:Object):void{
			if(call!=null){
				//"CustomText37",//Total Calls Current Quarter
				//"CustomCurrency2",//Expenses
				row.CustomText37= call.NumCall;
				row.CustomCurrency2 = call.Expenses;
			}
		}
		
		protected function plate2Row(result:Array,opid2Compititor:Dictionary,accId2Call:Dictionary):ArrayCollection{
			var dic:Dictionary = new Dictionary();
			var rows:ArrayCollection = new ArrayCollection();
			var opId2Row:Dictionary = new Dictionary();
			var opId2CategorySlected:Dictionary = new Dictionary();
			//row idenfify is opportunityId and category
			for each(var obj:Object in result){
				if(!StringUtils.isEmpty(obj.co7_Id)){
					var rId:String = obj.OpportunityId+"_"+obj.CustomPickList31;
					var row:Object=dic[rId];
					if(row==null){
						
						row = new Object();
						
						
						var categorySelected:ArrayCollection = opId2CategorySlected[obj.OpportunityId];
						if(categorySelected==null){
							categorySelected=new ArrayCollection();
							opId2CategorySlected[obj.OpportunityId]=categorySelected;
						}
						row.categorySelected=categorySelected;
						dic[rId]=row;
						rows.addItem(row);
						if(!opId2Row.hasOwnProperty(obj.OpportunityId)){
							opId2Row[obj.OpportunityId]=obj.OpportunityId;
							row.editable=true;
						
						}else{
							row.editable=false;
						}
					}
					//CustomPickList33 it is quater
					if(StringUtils.isEmpty(obj.CustomPickList33)){
						//it is product
						ArrayCollection(row.categorySelected).addItem(obj.CustomPickList31);
						Utils.copyObject(row,obj);
						//store original from db
						row.origOP = Utils.copyModel(obj,false);
						row.origCo7 = row.origOP;
						setCompititor(row,opid2Compititor[obj.OpportunityId]);
						setCallAndExpenses(row,accId2Call[obj.AccountId]);
					}else{
						//it is quater
						obj.origCo7 = Utils.copyModel(obj,false);
						row[obj.CustomPickList33]=obj;
					}
					
					
				}else{
					//opportunity no co7
					obj.isNoCo7=true;
					setCompititor(obj,opid2Compititor[obj.OpportunityId]);
					setCallAndExpenses(obj,accId2Call[obj.AccountId]);
					//store original from db
					obj.origOP = Utils.copyModel(obj,false);
					obj.categorySelected = new ArrayCollection();
					rows.addItem(obj);
				}
			}
			
			
			
			
			return rows;
		}
		
		private function saveCo7(fields:Array,obj:Object,quater:String=null,op:Object=null):void{
			var objSav:Object = new Object();
			for each (var f:String in fields){
				objSav[f]=obj[f];
				if(op!=null &&(objSav[f]==null||objSav[f]=='')){
					objSav[f]=op[f];
				}
			}
			objSav['gadget_id']=obj['co7_gadget_id'];
			if(op!=null){
				objSav.OpportunityId=op.OpportunityId;
				objSav.OpportunityName=op.OpportunityName;
				objSav.AccountName=op.AccountName;
				objSav.AccountId = op.AccountId;
				objSav.OpportunityAccountName=op.AccountName;
			}else{
				objSav.OpportunityId=obj.OpportunityId;
				objSav.OpportunityName=obj.OpportunityName;
				objSav.AccountName=obj.AccountName;
				objSav.AccountId = obj.AccountId;
				objSav.OpportunityAccountName=obj.AccountName;
			}
			
			//CustomPickList33 it is quater
			objSav.CustomPickList33=quater;
			if(!StringUtils.isEmpty(quater)){
				var total:Number =0;
				//save total of the quater
				for each(var m:String in MONTH_FIELD_FOR_EACH_Q){
					var strNum:String = obj[m];
					if(!StringUtils.isEmpty(strNum)){
						total+=parseFloat(strNum);
					}
				}
				objSav.CustomCurrency3=total;
			}
			delete objSav['co7_gadget_id'];
			if(StringUtils.isEmpty(objSav['gadget_id'])){
				//name is opportunityname_category_quater
				var name:String = objSav.OpportunityName+'_'+objSav.CustomPickList31;
				//CustomPickList33 is quater picklist
				if(!StringUtils.isEmpty(objSav.CustomPickList33)){
					name = name+'_'+objSav.CustomPickList33;
				}
				objSav.Name = name;
				//set owner 
				var dao:BaseDAO = Database.customObject7Dao;
				for each(var obj:Object in dao.getOwnerFields()){						
					objSav[obj.entityField] = Database.allUsersDao.ownerUser()[obj.userField];
				}
				
				
				Database.customObject7Dao.insert(objSav);
				var item:Object=Database.customObject7Dao.selectLastRecord()[0];
				item[DAOUtils.getOracleId(Database.customObject7Dao.entity)]="#"+item.gadget_id;
				Database.customObject7Dao.updateByField([DAOUtils.getOracleId(Database.customObject7Dao.entity)],item);
				obj.co7_gadget_id = item.gadget_id;
			}else{
				if(isChange(obj.origCo7,objSav,fields)){					
					objSav.local_update = new Date().getTime();
					objSav.ms_local_change = new Date().getTime();
					Database.customObject7Dao.updateByField(fields,objSav);
				}
			}
		}
		
		
		protected function isChange(orig:Object,updatedObj:Object,fields:Array):Boolean{
			for each (var f:String in fields) {
				if (orig[f] != updatedObj[f]) {					
					if (StringUtils.isEmpty(orig[f]) && StringUtils.isEmpty(updatedObj[f])) {
						continue;
					}	
					return true;					
				}
			}
			return false;
			
		}
		
		public function saveImpactCalendar(impactData:ArrayCollection,opField:Array,co7Fields:Array):void{
			Database.begin();
			try{
				for each(var row:Object in impactData){
					if(row.isTotal){
						continue;//total not save
					}
					if(row.editable){
						if(isChange(row.origOP,row,opField)){
							//update opportunity
							updateByField(opField,row);
						}
					}
					//save product usage
					saveCo7(co7Fields,row);
					for(var f:String in row){
						if(f!='categorySelected' && f!='origCo7' && f!='origOP'){
							if(row[f]!=null && typeof(row[f]) == "object"){
								//save quater
								saveCo7(co7Fields,row[f],f,row);
								
							}
						}
					}
				}
				Database.commit();
			}catch(e:SQLError){
				
				Database.rollback();
			}
			
			
		}
		
		
		
		override public function getOwnerFields():Array{
			var mapfields:Array = [
				{entityField:"OwnerFullName", userField:"FullName"},{entityField:"Owner", userField:"Alias"},{entityField:"OwnerId", userField:"Id"}
			];
			return mapfields;
			
		}
	}
	
}