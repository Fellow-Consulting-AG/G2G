package gadget.sync.tasklists
{
	import flash.utils.Dictionary;
	
	import gadget.dao.Database;
	import gadget.sync.incoming.IncomingObject;
	import gadget.sync.incoming.IncomingRelationObject;
	import gadget.util.Relation;
	import gadget.util.StringUtils;
	
	import mx.collections.ArrayCollection;

	public class IncomingStructure
	{
		private var levelTask:Dictionary = new Dictionary();
		//private var _listNotDependOn:Array=new Array();
		
		public function IncomingStructure()
		{  //always read users
			addTask(new IncomingObject(Database.allUsersDao.entity));
		}

		
		public function addTask(incomingTask:IncomingObject,level:int=0):void{
			if(incomingTask!=null){
				var listLevel:Array = levelTask[level] as Array;
				if(listLevel==null){
					listLevel = new Array();
					levelTask[level]=listLevel;
				}
				
				listLevel.push(incomingTask);
			}
		}
		/**
		 * return list of list task
		 * */
		public function getTaskAllLevel():ArrayCollection{
			var result:ArrayCollection = new ArrayCollection();
			for(var lev:int=0;;lev++){
				var listLevel:Array = levelTask[lev] as Array;
				if(listLevel==null){
					break;
				}else{
					result.addItem(listLevel);
				}
				
			}
			return result;
		}
		
//		public function addNotDependOn(incomingTask:IncomingObject):void{
//			if(incomingTask!=null){
//				_listNotDependOn.push(incomingTask);
//			}
//		}
		
		public function buildStructure(enablesTrans:ArrayCollection,dependOn:Boolean):void{
			var mapDependOn:Object = new Object();
			var listNotDepentOn:ArrayCollection = new ArrayCollection();
			for each(var obj:Object in enablesTrans){
				if(StringUtils.isEmpty(obj.parent_entity)){
					listNotDepentOn.addItem(obj);
				}else{
					var listDependOn:ArrayCollection = mapDependOn[obj.parent_entity];
					if(listDependOn==null){
						listDependOn = new ArrayCollection();
						mapDependOn[obj.parent_entity]=listDependOn;
					}
					listDependOn.addItem(obj);
				}
			}
			
			for each(var parent:Object in listNotDepentOn){
				var parentTask:IncomingObject = new IncomingObject(parent.entity);
				this.addTask(parentTask);				
				buildChildObject(mapDependOn,parentTask,parent.entity,1,dependOn);
			}
			
		}
		
		protected function buildChildObject(mapDependOn:Object,parentTask:IncomingObject,parentEntity:String,level:int,dependOn:Boolean):void{
			var listChild:ArrayCollection = mapDependOn[parentEntity];
			if(listChild!=null && listChild.length>0){
				for each(var child:Object in listChild){
					var relation:Object = Relation.getRelation(child.entity,parentEntity);
					var childRelation:Object = Relation.getRelation(parentEntity,child.entity);
					var childTask:IncomingObject = null;
					var objParentField:Object = new Object();
					if(childRelation!=null){
						objParentField.ChildRelationId=childRelation.keySrc;
					}
					if(relation!=null){
						objParentField.ParentRelationId=relation.keySrc;
					}
					
					if(!dependOn){
						var lastSyncObj:Object = Database.lastsyncDao.find(parentTask.getMyClassName());
						if(lastSyncObj!=null && lastSyncObj.sync_date!='01/01/1970 00:00:00'){
							childTask = new IncomingRelationObject(child.entity,parentTask,objParentField,false);							
						}else{
							childTask = new IncomingRelationObject(child.entity,parentTask,objParentField,true);							
						}
					}else{
						childTask = new IncomingRelationObject(child.entity,parentTask,objParentField,true);
						
					}
					this.addTask(childTask,level);
					var list:ArrayCollection = mapDependOn[child.entity];
					if(list!=null && list.length>0){
						buildChildObject(mapDependOn,childTask,child.entity,(level+1),dependOn);
					}
				}
			}
		}

		
	}
}