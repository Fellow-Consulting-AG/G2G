package gadget.control
{
	import flash.events.FocusEvent;
	
	import mx.controls.TextInput;

	public class ImpactText extends TextInput
	{
		public function ImpactText()
		{
			super();
		}
		public function set focusOutHandler(f:Function):void{
			addEventListener(FocusEvent.FOCUS_OUT,function(e:FocusEvent):void{f()});
		}
	}
}