package gadget.sync.incoming
{
	import flash.utils.Dictionary;
	
	import gadget.dao.ContactAccountDAO;
	import gadget.dao.Database;

	public class IncomingSubContact extends IncomingSubobjects
	{
		protected var deletedAlready:Dictionary = new Dictionary();
		
		public function IncomingSubContact(ID:String, _subID:String)
		{
			super(ID, _subID);
			isUsedLastModified=false;
		}
		override protected function doRequest():void {
			startTime=-1;//always get all sub by parentid
			super.doRequest();
		}
		override protected function handleResponse(request:XML, response:XML):int {
			var listObject:XML = response.child(new QName(ns2.uri,listID))[0];
			var lastPage:Boolean = listObject.attribute("lastpage")[0].toString() == 'true';
			var lastSubPage:Boolean = true;
			var qsublist:QName = new QName(ns2.uri,subList);
			var cnt:int=0;
			
			Database.begin();
			try{
				for each (var parentRec:XML in listObject.child(new QName(ns2.uri,entityIDns))) {
					var subObject:XML = parentRec.child(qsublist)[0];
					
					this.pid =  parentRec.child(new QName(ns2.uri,"Id"))[0].toString();	
					lastSubPage = lastSubPage && ( subObject.attribute("lastpage")[0].toString() == 'true' );
					if(!deletedAlready.hasOwnProperty(this.pid)){
						var criteria:Object = new Object();
						if(subDao is ContactAccountDAO){
							criteria['AccountId'] = this.pid;
						}else{
							criteria['ContactId'] = this.pid;	
						}
						 
						subDao.deleteOnlyRecordeNotErrorByParent(criteria);
						deletedAlready[this.pid]=this.pid;
					}
					var nr:int = importRecords(subIDsod, subObject.child(new QName(ns2.uri,subIDns)));
					if (nr<0) {
						//Database.commit();
						return cnt;
					}
					cnt += nr;
				}
				
			}finally{
				Database.commit();
			}
			nextSubPage(lastPage,lastSubPage);
			return cnt;
			
		}
		
		
		
	}
}