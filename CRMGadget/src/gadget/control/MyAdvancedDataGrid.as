package gadget.control
{
	import flash.display.Sprite;
	
	import gadget.assessment.AssessmentSectionTotal;
	
	import mx.controls.AdvancedDataGrid;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.core.IInvalidating;
	
	public class MyAdvancedDataGrid extends AdvancedDataGrid
	{
		
		private var _drawBg:Boolean=true;
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
			
			public function refreshRow(row:int):void{
				if(row>-1 && row<listItems.length){
					var colRenderers:Array = listItems[row];
					for each(var r:Object in colRenderers){
						var listData:AdvancedDataGridListData = AdvancedDataGridListData(IDropInListItemRenderer(r).listData);
						listData.label = _columns[listData.columnIndex].itemToLabel(r.data);
						IDropInListItemRenderer(r).listData = listData;
					}
				}
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
					}
				}
				
			}

		public function set drawBg(value:Boolean):void
		{
			_drawBg = value;
		}
			
			
		
	}
}