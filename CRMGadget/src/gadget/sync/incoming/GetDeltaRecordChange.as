package gadget.sync.incoming
{
	import flash.utils.Dictionary;
	
	import gadget.dao.BaseDAO;
	import gadget.dao.DAOUtils;
	import gadget.dao.Database;
	import gadget.sync.WSProps;
	import gadget.util.FieldUtils;
	import gadget.util.SodUtils;
	
	import mx.collections.ArrayCollection;

	public class GetDeltaRecordChange extends JDIncomingProduct
	{
		protected var finishFunc:Function;
		protected var listIds:ArrayCollection = new ArrayCollection();
		protected var oracleFieldId:String;
		public function GetDeltaRecordChange(searchSpec:String,entity:String,finishFunc:Function)
		{
			this.finishFunc = finishFunc;
			this.oracleFieldId = DAOUtils.getOracleId(entity);
			super(searchSpec,entity);
		}
	
		
		
		
		protected override function getViewmode():String{
			return "Broadest";
		}
		
		override protected function handleErrorGeneric(soapAction:String, request:XML, response:XML, mess:String, errors:XMLList):Boolean {
			if(finishFunc!=null){//retry by manual
				finishFunc(listIds);
			}
			return true;
		}
		
		
		override protected function handleResponse(request:XML, response:XML):int {
			var ns:Namespace = getResponseNamespace();
			var listObject:XML = response.child(new QName(ns.uri,listID))[0];
			var lastPage:Boolean = listObject.attribute("lastpage")[0].toString() == 'true';			
			var cnt:int = importRecords(entityIDsod, listObject.child(new QName(ns.uri,entityIDns)));			
			nextPage(lastPage);
			return cnt;
		}
	
		override protected function getFields(alwaysRead:Boolean=false):ArrayCollection{
			return new ArrayCollection([{element_name:oracleFieldId}]);
		}
		
		protected override function initXML(baseXML:XML):void {
			
			
			var qlist:QName=new QName(ns1.uri,listID), qent:QName=new QName(ns1.uri,entityIDns);	
			
			var xml:XML = baseXML.child(qlist)[0].child(qent)[0];
			var hasActivityParent:Boolean = false;
			var ignoreFields:Dictionary = dao.incomingIgnoreFields;
			for each (var field:Object in getFields(true)) {				
				if(!ignoreFields.hasOwnProperty(field.element_name)){
					if (ignoreQueryFields.indexOf(field.element_name)<0) {
						var ws20name:String = WSProps.ws10to20(entityIDsod, field.element_name);
						xml.appendChild(new XML("<" + ws20name + "/>"));
					}
				}
			}
		
			
			
			
		}
		
		
		
		
		protected override function importRecord(entitySod:String, data:XML, googleListUpdate:ArrayCollection=null):int {
			var tmpOb:Object={};
			var hasActivityParent:Boolean = false;
			for each (var field:Object in getFields()) {
				tmpOb[field.element_name] = getValue(entitySod,data,WSProps.ws10to20(entitySod,field.element_name));	
			}
			//right now we need only oracle id
			listIds.addItem(tmpOb[oracleFieldId]);
			
			return 1;
		}
		
		protected override function nextPage(lastPage:Boolean):void {
			
			
			if (lastPage) {
				if(finishFunc!=null){
					finishFunc(listIds);
				}
			}else{				
				_page ++;
				doRequest();//next paage
			}
			
		}
		
	}
}