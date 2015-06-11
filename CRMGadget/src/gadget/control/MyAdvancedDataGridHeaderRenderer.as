package gadget.control
{

	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import gadget.util.ImageUtils;
	
	import mx.containers.HBox;
	import mx.controls.AdvancedDataGrid;
	import mx.controls.LinkButton;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridHeaderRenderer;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	
	public class MyAdvancedDataGridHeaderRenderer extends AdvancedDataGridHeaderRenderer
	{
		private var _addColapeOrExpand:Boolean=false;
		private var _colapOrExpandClick:Function;

		public function get colapOrExpandClick():Function
		{
			return _colapOrExpandClick;
		}

		public function set colapOrExpandClick(value:Function):void
		{
			_colapOrExpandClick = value;
		}

		public function get addColapeOrExpand():Boolean
		{
			return _addColapeOrExpand;
		}

		public function set addColapeOrExpand(value:Boolean):void
		{
			_addColapeOrExpand = value;
		}


		public function MyAdvancedDataGridHeaderRenderer()
		{
			super();
		}
		private var _switchCol:LinkButton;
		private var _right:Boolean = true;
		private var _colName:String;
		private function switchCol(e:Event):void{
			if (_right) {
				_switchCol.setStyle("icon", ImageUtils.rightIcon);
				
			} else {
				_switchCol.setStyle("icon", ImageUtils.leftIcon);
				
			}
			if(colapOrExpandClick!=null){
				colapOrExpandClick(!_right,_colName);
			}
			_right=!_right;
			
		}

		
		protected override function createChildren():void{
			super.createChildren();
			if(addColapeOrExpand && _switchCol==null){
				//<mx:LinkButton id="switchFilter" width="12" height="24" icon="{ImageUtils.leftIcon}" click="switchFilterList(event)" />
				_switchCol = new LinkButton();
				_switchCol.width=12;
				_switchCol.height=30;
				_switchCol.setStyle("icon", ImageUtils.leftIcon);
				_switchCol.addEventListener(MouseEvent.CLICK,switchCol);
				_switchCol.x=label.x+this.width;
				addChild(_switchCol);
				
				
			}
		}

		public function get colName():String
		{
			return _colName;
		}

		public function set colName(value:String):void
		{
			_colName = value;
		}

	}
}