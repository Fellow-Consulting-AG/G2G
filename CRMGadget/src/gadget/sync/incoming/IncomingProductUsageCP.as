package gadget.sync.incoming
{
	import gadget.dao.Database;
	import gadget.i18n.i18n;
	import gadget.util.DateUtils;
	import gadget.util.GUIUtils;
	
	public class IncomingProductUsageCP extends IncomingRelationObject
	{
		public function IncomingProductUsageCP(entity:String, parentFieldId:String)
		{
			super(Database.customObject7Dao.entity, new IncomingRelationObject(entity), {"ParentRelationId":parentFieldId}, true);
		}
		
		override  public function getName() : String {
			return i18n._('Reading "{1}" data from server', parentTask.getEntityName()+"."+getEntityName());
		}
		
		override public function done():void{
			if(Database.activityDao.entity==parentTask.entityIDour){
				Database.incomingSyncDao.unsync_one(Database.customObject7Dao.entity);
				var time:GetTime = new GetTime(); 
				time.call(false, param.preferences, 
					function (date:String):void {
						try {
							var lastSync:Date = DateUtils.guessAndParse(date);
							var startDate:Date = DateUtils.guessAndParse("1970-01-01T00:00:00");
							Database.incomingSyncDao.addRange(Database.customObject7Dao.entity,{start:startDate, end:lastSync });
						} catch (e:Error) {
							failErrorHandler_err2(null, e);
						}	
					}, 
					param.warningHandler,
					param.errorHandler, null, null);
				
			
				
				
			}
		}
	}
}