package gadget.sync.incoming
{
	import flash.utils.getQualifiedClassName;
	
	import gadget.dao.DAOUtils;
	import gadget.dao.Database;
	import gadget.util.ObjectUtils;
	import gadget.util.StringUtils;
	
	import mx.collections.ArrayCollection;
	
	public class IncomingRelationObject extends IncomingObject
	{
		
		private var _parentTask:IncomingObject;
		private var _parentRelationField:Object;
		private var _dependOnParent:Boolean = false;
		private var _currentMinIndex:int =0;
		private var _currentMaxIndex:int = 50;
		private var _parentRecord:int=0;
		/**
		 * parentFieldIds has properties ChildRelationId,ParentRelationId
		 * */
		public function IncomingRelationObject(entity:String, parentTask:IncomingObject=null, parentFieldIds:Object=null, dependOnParent:Boolean=false)
		{
			super(entity);
			this._parentTask = parentTask;
			this._dependOnParent = dependOnParent;
			this._parentRelationField = parentFieldIds;
		}
		
		
	
		public function get dependOnParent():Boolean
		{
			return _dependOnParent;
		}
		
		public function get parentRelationField():Object
		{
			return _parentRelationField;
		}
		
		public function set parentRelationField(value:Object):void
		{
			_parentRelationField = value;
		}
		
		public function get parentTask():IncomingObject
		{
			return _parentTask;
		}
		
		public function set parentTask(value:IncomingObject):void
		{
			_parentTask = value;
		}
		
		
		
		protected override function canSave(incomingObject:Object):Boolean{
			
			var parentId:String=incomingObject[parentRelationField.ParentRelationId];
			var issave:Boolean = false;
			if(StringUtils.isEmpty(parentId)){
				if(parentRelationField.hasOwnProperty('ChildRelationId')){
					var criteria:Object = new Object();
					criteria[parentRelationField.ChildRelationId] = incomingObject[DAOUtils.getOracleId(entityIDour)];
					var parentObject:Object = parentTask.dao.getByParentId(criteria);				
					issave = parentObject!=null;
				}
			}else{
				var parentObject1:Object = parentTask.dao.findByOracleId(parentId);
				issave = parentObject1!=null;			
			}
			if(issave){
				listRetrieveId.addItem(incomingObject);
			}
			
			return issave;
		}
		
		
		override protected function doRequest():void {
			if( dependOnParent && (_currentMinIndex>=parentTask.listRetrieveId.length)){
				super.nextPage(true);
			}else{
				
				super.doRequest();
			}
		}
		
		
		protected override function generateSearchSpec(byModiDate:Boolean=true):String{			
			this.isUnboundedTask = true;
			if(!dependOnParent){
				return super.generateSearchSpec();
			}else{				
				var first:Boolean = true;
				var searchProductSpec:String = "";
				var maxIndex:int = Math.min(_currentMaxIndex,parentTask.listRetrieveId.length);
				_parentRecord=1;
				for(_currentMinIndex; _currentMinIndex<maxIndex;_currentMinIndex++){
					_parentRecord++;
					var parentObj:Object = parentTask.listRetrieveId.getItemAt(_currentMinIndex);
					if(parentObj==null){
						continue;
					}
					if(!first){
						searchProductSpec=searchProductSpec+" OR ";
					}
					searchProductSpec=searchProductSpec+"["+parentRelationField.ParentRelationId+"] = \'"+parentObj[DAOUtils.getOracleId(parentTask.entityIDour)]+'\'';
					if(!StringUtils.isEmpty(parentRelationField.ChildRelationId) && parentObj.hasOwnProperty(parentRelationField.ChildRelationId)){
						var thisId:String = parentObj[parentRelationField.ChildRelationId];	
						if(!StringUtils.isEmpty(thisId)){
							searchProductSpec=searchProductSpec+" OR ";
							searchProductSpec=searchProductSpec+"[Id]=\'"+thisId+"\'";;
						}
					}
									
					first = false;
				}
				
				
				var superCriteria:String = super.generateSearchSpec(false);
				if(StringUtils.isEmpty(superCriteria)){
					superCriteria=searchProductSpec;
				}else{
					superCriteria+=' AND ('+searchProductSpec+')';
				}
				
				return superCriteria;
			}
		}
		
		protected override function nextPage(lastPage:Boolean):void {
			if(!dependOnParent){
				super.nextPage(lastPage);
			}else{
				showCount();
				if(lastPage){
					if(_currentMaxIndex>=parentTask.listRetrieveId.length){						
						super.nextPage(true);
					}else{
						_currentMinIndex = _currentMaxIndex;
						_currentMaxIndex+=50;//incrase max
						_page=0;
						doRequest();
					}
				}else{
					
					_currentMinIndex=Math.max(0,(_currentMinIndex-_parentRecord));
					_page++;
					doRequest();
				}
				
			}
		}
	}
}