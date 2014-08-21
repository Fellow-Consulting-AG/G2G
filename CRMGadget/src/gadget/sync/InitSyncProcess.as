package gadget.sync
{
	import gadget.sync.group.TaskGroupBase;
	import gadget.sync.incoming.GetConfigXml;
	import gadget.sync.incoming.IncomingCurrentUserData;
	import gadget.sync.incoming.IncomingUser;

	public class InitSyncProcess extends SyncProcess
	{
		public function InitSyncProcess()
		{
			super(false, false, false, false, null, null);
		}
		
		
		protected override function buildTask(full:Boolean,isParalleProcessing:Boolean=false,isSRSynNow:Boolean=false,records:Array=null,checkConflicts:Array=null):void{
			this._groups.addItem(new TaskGroupBase(
				this,
				[new IncomingUser(),
					new IncomingCurrentUserData(),new GetConfigXml()],false,false));		
		}
		
		
		protected override function doLogProgress():void {
			if(_logProgress!=null){
				//default is 1
				_logProgress(1);
			}
		}
		
		protected override function nextGroup(finished:Object):void {
			_finished = true;//have only one group
			super.nextGroup(finished);
		}
		
		protected override function groupEnd():void {
			//nothing todo
			
		}
		
	}
}