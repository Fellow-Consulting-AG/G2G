package gadget.dao
{
	
	
	import flash.data.SQLConnection;
	import flash.utils.Dictionary;
	
	import gadget.util.StringUtils;

	public class AddressFieldTranslatorDAO extends SimpleTable
	{
		
		private static const ADDRESS:String = 'address';
		private static const ADDRESS2:String = 'address2';
		private static const ADDRESS3:String = 'address3';
		private static const CITY:String='city';
		private static const COUNTY:String='county';
		private static const STATE:String = 'state';
		private static const ZIP:String = 'zip';
		private static const PROVINCE:String = 'province';
		private var dic:Dictionary = null;
		
		public function AddressFieldTranslatorDAO(sqlConnection:SQLConnection,work:Function)
		{
			super(sqlConnection, work, {
				table: 'address_field_translator',
				index: ["name", "lang","country"],
				unique : ["name,lang,country"],
				columns: {gadget_id: "INTEGER PRIMARY KEY AUTOINCREMENT", 'TEXT' : ["name", "lang","country","word"]}
			});
			
		}
	
		private static const DEFAULT_TRANSLATE:Object ={
			ENU:[{name:ADDRESS,word:'Number/Street','country':'USA'},
				{name:ADDRESS2,word:'Address 2','country':'USA'},
				{name:ADDRESS3,word:'Address 3','country':'USA'},
				{name:CITY,word:'City','country':'USA'},
				{name:COUNTY,word:'County','country':'USA'},
				{name:STATE,word:'State','country':'USA'},
				{name:ZIP,word:'Zip/Post Code','country':'USA'},
				{name:PROVINCE,word:'Provine','country':'USA'},
				{name:'country',word:'Country','country':'USA'}],
			DEU:[{name:ADDRESS,word:'Hausnummer/Straße','country':'USA'},
				{name:ADDRESS2,word:'Address 2','country':'USA'},
				{name:ADDRESS3,word:'Address 3','country':'USA'},
				{name:CITY,word:'Ort','country':'USA'},
				{name:COUNTY,word:'Kreis','country':'USA'},
				{name:STATE,word:'Staat','country':'USA'},
				{name:ZIP,word:'PLZ','country':'USA'},
				{name:PROVINCE,word:'Provinz','country':'USA'},
				{name:'country',word:'Land ','country':'USA'}],
			CHS:[{name:ADDRESS,word:'街道/门牌','country':'USA'},
				{name:ADDRESS2,word:'地址 2','country':'USA'},
				{name:ADDRESS3,word:'地址 3','country':'USA'},
				{name:CITY,word:'城市','country':'USA'},
				{name:COUNTY,word:'郡县','country':'USA'},
				{name:STATE,word:'省/（直辖）市','country':'USA'},
				{name:ZIP,word:'邮政编码','country':'USA'},
				{name:PROVINCE,word:'省/自治区','country':'USA'},
				{name:'country',word:'国家/地区 ','country':'USA'}]		
		
		};
		
		public function init():void{
			if(countRecord()<1){
				for (var lang:String in DEFAULT_TRANSLATE){
					var obj:Array = DEFAULT_TRANSLATE[lang] as Array;
					for each(var rec:Object in obj){
						rec.lang=lang;
						insert(rec);
					}
				}
			}
		}
		
		private function translator(name:String, lang:String):String{
			if(dic==null){
				dic = new Dictionary();
				for each(var obj:Object in fetch()){
					var group:Dictionary = dic[obj.lang];
					if(group==null){
						group = new Dictionary();
						dic[obj.lang] = group;
					}
					group[obj.name]=obj.word;
				}
			}
			var map:Dictionary = dic[lang] as Dictionary;
			var word:String = map[name];
			if(StringUtils.isEmpty(word)){
				map = dic['ENU'];//default lange
				word = map[name];
			}
			
			return word;
		}
		public function getDisplayName(name:String,country:String=null):String{
			var lang:String = Database.allUsersDao.ownerUser().LanguageCode;
			return translator(name,lang);
		}
		
		
	}
}