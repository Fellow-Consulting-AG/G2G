package gadget.dao
{
	import flash.data.SQLConnection;
	
	public class ContactAccountDAO extends SupportDAO {

		public function ContactAccountDAO(sqlConnection:SQLConnection, work:Function) {

			super(work, sqlConnection, {
				entity: [ 'Contact',   'Account'   ],
				id:     [ 'ContactId', 'AccountId' ],
				columns: TEXTCOLUMNS
			},{
//				record_type:"Account Contact",
				unique:['ContactId,AccountId'],
				name_column:["AccountName"],
				search_columns:["AccountName"],
				oracle_id:"Id",		//VAHI's not so evil kludge
				columns: { DummySiebelRowId:{type:"TEXT", init:"gadget_id" } }
			});
			SupportRegistry.init_registry('Account.Contact' , this);
			_isSyncWithParent = false;
			_isGetField = true;
		}

		private const TEXTCOLUMNS:Array = [
			ID("Id"),
			
			PICK("AccountExternalSystemId","AccountId"),
			PICK("AccountName","AccountId"),
			PICK("AccountIntegrationId","AccountId"),
			PICK("AccountLocation","AccountId"),
			PICK("AccountMainPhone","AccountId"),
			PICK("AccountType","AccountId"),

			PICK("ContactEmail","ContactId"),
			PICK("ContactExternalSystemId","ContactId","ExternalSystemId"),
			PICK("ContactFirstName","ContactId"),
			PICK("ContactFullName","ContactId"),
			PICK("ContactIntegrationId","ContactId","IntegrationId"),
			PICK("ContactJobTitle","ContactId","JobTitle"),
			PICK("ContactLastName","ContactId"),
			PICK("ContactType","ContactId"),
			PICK("ContactWorkPhone","ContactId","WorkPhone"),

			"AccountId",
			"ContactId",
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

			"Description",		// comment (non-mandatory title)

			"ModId",
			"ModifiedBy",
			"ModifiedById",
			"ModifiedDate",

			"PrimaryAccount",	// Boolean
			"PrimaryContact",	// Boolean

			"Role",				//VAHI I really have no idea
			"RoleList",			//VAHI I really have no idea

			"UpdatedByAlias",
			"UpdatedByEMailAddr",
			"UpdatedByExternalSystemId",
			"UpdatedByFirstName",
			"UpdatedByFullName",
			"UpdatedByIntegrationId",
			"UpdatedByLastName",
			"UpdatedByUserSignInId",
			];
	}
}