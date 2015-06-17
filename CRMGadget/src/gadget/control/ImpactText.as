package gadget.control
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	
	import gadget.util.StringUtils;
	
	import mx.collections.ArrayCollection;
	import mx.controls.AdvancedDataGrid;
	import mx.controls.TextInput;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
	import mx.controls.listClasses.BaseListData;

	public class ImpactText extends TextInput
	{
		
		
		public var column:AdvancedDataGridColumn;
		protected var grid:AdvancedDataGrid = null;		
		private var _refreshRow:Boolean = true;
		private var _updateData:Function;
		public function ImpactText()
		{
			addEventListener(Event.CHANGE,onChange);
			super();
		}

		
		public function set focusOutHandler(f:Function):void{
			
			addEventListener(FocusEvent.FOCUS_OUT,function(e:FocusEvent):void{f()});
		}
		
		protected function onChange(e:Event):void{
			
					
					if(column != null){
						var colName:String = column.dataField;
						if(colName.indexOf('.')!=-1){
							var fields:Array = colName.split('.');
							var q:Object = data[fields[0]];
							if(q==null){
								q=new Object();
								super.data[fields[0]]=q;
							}
							q[fields[1]]=super.text;
						}else{
							super.data[colName]=super.text;
						}
						if(updateData!=null){
							var newVal:Object = new Object();
							newVal[colName]=super.text;
							updateData(super.data,newVal);
						}
						
						
						if(grid is MyAdvancedDataGrid && refreshRow){
							MyAdvancedDataGrid(grid).refreshRow(super.listData.rowIndex);
						}
						
					}

		}
		override public function set data(value:Object):void{
			super.data = value;
			setFocus();
			if(!StringUtils.isEmpty(super.text)){
				setSelection(super.text.length,super.text.length);
			}
		}
		
		override public function set listData(value:BaseListData):void
		{
			
			super.listData = value;
			if(value!=null){
				grid = value.owner as AdvancedDataGrid;
				var list:AdvancedDataGridListData = value as AdvancedDataGridListData;
				if(list!=null){					
					column = grid.columns[list.columnIndex];
					
				}
				
			}
		}

		public function get refreshRow():Boolean
		{
			return _refreshRow;
		}

		public function set refreshRow(value:Boolean):void
		{
			_refreshRow = value;
		}

		public function get updateData():Function
		{
			return _updateData;
		}

		public function set updateData(value:Function):void
		{
			_updateData = value;
		}


	}
}