package gadget.sync.incoming
{
	import gadget.dao.Database;
	import gadget.i18n.i18n;
	import gadget.util.StringUtils;
	
	import mx.collections.ArrayCollection;
	
	import org.purepdf.pdf.ArabicLigaturizer;

	public class IncomingContactNotExistInAccCon extends IncomingObject
	{
		
		private var _currentMinIndex:int =0;
		private var _currentMaxIndex:int = 50;
		private var _parentRecord:int=0;
		private var _ListMissingIds:ArrayCollection;
		public function IncomingContactNotExistInAccCon()
		{
			super(Database.contactDao.entity);
			
		}
		
		
		override protected function doRequest():void {		
			this.isUnboundedTask = true;
			if(_ListMissingIds==null){
				_ListMissingIds=Database.contactAccountDao.findMissingContact();
			}
			if(_ListMissingIds==null ||_currentMinIndex>=_ListMissingIds.length){
				super.nextPage(true);
			}else{
				
				super.doRequest();
			}
		}
		
		override  public function getName() : String {
			return i18n._('Reading "ContactAccount" data from server');
		}
		
		protected override function nextPage(lastPage:Boolean):void {
			
				showCount();
				if(lastPage){
					if(_currentMaxIndex>=_ListMissingIds.length){						
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
		
		override protected function generateSearchSpec(byModiDate:Boolean=true):String{
			var first:Boolean = true;
			var searchProductSpec:String = "";
			var maxIndex:int = Math.min(_currentMaxIndex,_ListMissingIds.length);
			_parentRecord=1;
			for(_currentMinIndex; _currentMinIndex<maxIndex;_currentMinIndex++){
				_parentRecord++;
				var id:String =_ListMissingIds.getItemAt(_currentMinIndex) as String;
				if(StringUtils.isEmpty(id)){
					continue;
				}
				if(!first){
					searchProductSpec=searchProductSpec+" OR ";
				}
				searchProductSpec=searchProductSpec+"[Id] = \'"+id+'\'';
				
				
				first = false;
			}
			return searchProductSpec;
		}
	}
}