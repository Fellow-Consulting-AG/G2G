package gadget.control
{
		
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import gadget.assessment.AssessmentSectionTotal;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.controls.AdvancedDataGrid;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.scrollClasses.ScrollBar;
	import mx.core.IInvalidating;
	import mx.core.UIComponent;
	
	public class MyAdvancedDataGrid extends AdvancedDataGrid
	{
		
		private var _drawBg:Boolean=true;
		private var _refreshFunction:Function;
		private var _impactCalendarGrid:Boolean=false;
		
		public function MyAdvancedDataGrid()
		{
			super();
		}
		
		
			
			protected override function drawRowBackground(s:Sprite, rowIndex:int, y:Number, height:Number, color:uint, dataIndex:int):void{
				if(collection!=null && _drawBg){
					var row:Object=rowNumberToData(dataIndex);		       
					if(row!=null && !(row is AssessmentSectionTotal)){		  
						if(!row["hasCheckbox"] ){
							color=0xECECEC;   		
						}else{
							color=0xFFFFFF;
						}			     		     
					} 		      
				}
				super.drawRowBackground(s,rowIndex,y,height,color,dataIndex);		    
			} 
			
			public function refreshRow(row:int,refDependOnGrid:Boolean=true):void{
				if(row>-1 && row<listItems.length){
					var colRenderers:Array = listItems[row];
					for each(var r:Object in colRenderers){
						if (r is ButtonAddRenderer)
						{
							ButtonAddRenderer(r).data=ButtonAddRenderer(r).data;//show/hihe button
						}else if( r is LinkButtonRevenueColRenderer){
							r.data = r.data;//refresh label
						}else{
							var listData:AdvancedDataGridListData = AdvancedDataGridListData(IDropInListItemRenderer(r).listData);
							listData.label = _columns[listData.columnIndex].itemToLabel(r.data);
							IDropInListItemRenderer(r).listData = listData;
						}
						
					}
					if(refDependOnGrid){
						refreshDependOnGrid();
					}
				}
			}
			
			public function refreshRowByRecordId(recId:String,idField:String):void{
				for(var i:int=0;i<listItems.length;i++){
					var firstCol:Object = listItems[i][0];
					if(firstCol!=null){
						var row:Object = firstCol.data;
						if(row!=null && row[idField]==recId){
							refreshRow(i,false);
						}
					}
				}
				refreshDependOnGrid();
			}
			
			public function refreshCols(col:int):void{
				if(col<0){
					return;
				}
				for each(var row:Array in listItems){
					if(row.length>col){
						var r:Object = row[col];
						var listData:AdvancedDataGridListData = AdvancedDataGridListData(IDropInListItemRenderer(r).listData);
						listData.label = _columns[col].itemToLabel(r.data);
						IDropInListItemRenderer(r).listData = listData;
					}
				} 
				refreshDependOnGrid();
			
			}
			private function refreshDependOnGrid():void{
				if(this._refreshFunction!=null){
					this._refreshFunction();
					
				}
			}
			public function refreshCell(row:int,col:int):void{
				if(row>-1 && col>-1){
					if(row<listItems.length){
						var colRenderers:Array = listItems[row];
						if(col<colRenderers.length){
							var r:Object = colRenderers[col];
							
							var listData:AdvancedDataGridListData = AdvancedDataGridListData(IDropInListItemRenderer(r).listData);
							listData.label = _columns[col].itemToLabel(r.data);
							IDropInListItemRenderer(r).listData = listData;
						}
						refreshDependOnGrid();
					}
				}
				
			}

		public function set drawBg(value:Boolean):void
		{
			_drawBg = value;
		}

		public function set refreshFunction(value:Function):void
		{
			_refreshFunction = value;
		}
			
		override protected function editorKeyDownHandler(event:KeyboardEvent):void
		{
			if(editedItemPosition!=null){
				super.editorKeyDownHandler(event);
			}
		}	
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if(impactCalendarGrid){	
				this.width= parent.width;
			}
		}
		
		public function get verticalScroll():ScrollBar{
			return this.verticalScrollBar;
		}
		
		
		override protected function keyDownHandler(event:KeyboardEvent):void
		{
			super.keyDownHandler(event);
//			if(event.keyCode==Keyboard.TAB){
//				if(editedItemPosition!=null){
//					var renderer:Object = listItems[editedItemPosition.rowIndex][editedItemPosition.columnIndex];
//				}
//			}
			if(editedItemPosition!=null && impactCalendarGrid && event.keyCode==Keyboard.TAB){
				
			}
			
		}

		public function get impactCalendarGrid():Boolean
		{
			return _impactCalendarGrid;
		}

		public function set impactCalendarGrid(value:Boolean):void
		{
			_impactCalendarGrid = value;			
		}

		
	}
}