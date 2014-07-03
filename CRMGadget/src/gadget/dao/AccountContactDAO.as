// Arnaud noted to me (VAHI) that the Id field apparently contains the ContactId.
// I am not completely sure that this field is not in fact the PartyId (which then
// happens to be the ContactId most time, but not always).
//
// Let's see how it works out.  Hopefully Arnaud is right.
// So this DAO now is implemented using following properties:
//
// A) ActivityId is missing and added on the fly in Sync - currently by a Hack of Arnaud
// B) ContactId is taken from the "Id" field
// C) There is no oracle Id.  Instead we use gadget_id for this.
//
// The C) is especially evil, the alternative would be to create an artificial column
// which is not needed at all and not filled at all.  However this column then always
// is NULL, which perhaps makes it impossible to update certain records.

package gadget.dao
{
	import flash.data.SQLConnection;
	import flash.utils.Dictionary;
	
	import gadget.util.StringUtils;
	
	import mx.collections.ArrayCollection;
	
	public class AccountContactDAO extends SupportDAO {
		
		public function AccountContactDAO(sqlConnection:SQLConnection, work:Function) {
			super(work, sqlConnection, {
				entity: ['Account',   'Contact'],
				id:     ['AccountId', 'ContactId' ],
				columns: TEXTCOLUMNS
			}
			,{
//				record_type:"AccountContact",
				unique:['AccountId,ContactId'],
				clean_table:true,
				name_column:["ContactFullName"],
				search_columns:["ContactFullName"],
				oracle_id:"Id",		//VAHI's not so evil kludge
				columns: { DummySiebelRowId:{type:"TEXT", init:"gadget_id" } }
			});
			_isSyncWithParent = false;
			_isGetField = true;
		}
		public override function getLinkFields():Dictionary{
			var fields:Dictionary = new Dictionary();
			fields["ContactLastName"]=Database.contactDao.entity;
			return fields;
			
		}
		/*
		override public final function fix_sync_incoming(ob:Object, assoc:Object=null):Boolean {
			//Fiddle in the ActivityId which is missing
			ob.AccountId = assoc.AccountId;
		//	ob.Subject = assoc.Subject;		// It cannot hurt to do this.

			//try to find DummySiebelRowId for a matching record
			ob.DummySiebelRowId = StringUtils.toString(b_value("DummySiebelRowId",{AccountId:ob.AccountId,Id:ob.Id}));
			return true;
		}

		override public function fix_sync_add(ob:Object,parent:Object=null):void {
			b_exec("UPDATE", "SET DummySiebelRowId=gadget_id WHERE DummySiebelRowId IS NULL");
		}
		
		override public final function fix_sync_outgoing(ob:Object):Boolean {
			ob.DummySiebelRowId = ob.gadget_id;
			return true;
		}
		*/
		private const TEXTCOLUMNS:Array = [
			"CreatedDate",
			"ModifiedById",
			"CreatedById",
			"ModId",
			"Id",
			"ContactFullName",
			"PrimaryContact",
			"PrimaryAccount",
			"Role",
			"AccountName",
			"AccountType",
			"AccountLocation",
			"AccountMainPhone",
			"RoleList",
			"Description",
			"ContactIntegrationId",
			"AccountIntegrationId",
			"AccountExternalSystemId",
			"ContactExternalSystemId",
			"ContactType",
			"AccountId",
			"ContactId",
			"ContactFirstName",
			"ContactLastName",
			"ContactEmail",
			"ContactJobTitle",
			"ContactWorkPhone",
			"CurrencyCode",
			"ExchangeDate",
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
		];
	}
}
