package gadget.control
{

	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import gadget.i18n.i18n;
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
				_switchCol.toolTip = i18n._('SHOW_MONTHS@Show Months');
			} else {
				_switchCol.setStyle("icon", ImageUtils.leftIcon);
				_switchCol.toolTip = i18n._('HIDE_MONTHS@Hide Months');
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
				_switchCol.height=20;
				_switchCol.setStyle("icon", ImageUtils.leftIcon);
				_switchCol.toolTip = i18n._('HIDE_MONTHS@Hide Months');
				_switchCol.addEventListener(MouseEvent.CLICK,switchCol);
				
				addChild(_switchCol);
				
				
			}
		}
		
		/**
		 *  @private
		 */
		override protected function updateDisplayList(unscaledWidth:Number,
													  unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			if(_switchCol!=null){
				
				_switchCol.x=unscaledWidth-15;
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