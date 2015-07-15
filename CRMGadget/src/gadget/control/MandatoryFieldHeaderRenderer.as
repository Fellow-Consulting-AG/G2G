package gadget.control
{
	import flash.display.DisplayObject;
	
	import mx.controls.advancedDataGridClasses.AdvancedDataGridHeaderRenderer;
	
	public class MandatoryFieldHeaderRenderer extends AdvancedDataGridHeaderRenderer
	{
		public function MandatoryFieldHeaderRenderer()
		{
			super();
			//setStyle("backgroundColor","#40E0D0");
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			// Set background size, position, color
			if (background)
			{
				background.graphics.clear();
				background.graphics.beginFill(0x40E0D0, 0x40E0D0); // transparent
				background.graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
				background.graphics.endFill();
				setChildIndex( DisplayObject(background), 0 );
			}
		}
		
		
	}
}