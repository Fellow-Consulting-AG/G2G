package
{
	
	
	import com.assessment.DtoAssessmentPDFHeader;
	import com.assessment.DtoColumn;
	import com.assessment.DtoConfiguration;
	import com.assessment.DtoPage;
	
	import flash.filesystem.File;
	import flash.utils.Dictionary;
	
	import gadget.assessment.AssessmentModelTotal;
	import gadget.assessment.AssessmentPageTotal;
	import gadget.assessment.AssessmentSectionTotal;
	import gadget.assessment.IAssessmentTotal;
	import gadget.control.CustomPurePDF;
	import gadget.dao.ActivityDAO;
	import gadget.dao.AssessmentPDFColorThemeDAO;
	import gadget.dao.Database;
	import gadget.i18n.i18n;
	import gadget.service.PicklistService;
	import gadget.util.DateUtils;
	import gadget.util.FieldUtils;
	import gadget.util.StringUtils;
	import gadget.util.Utils;
	
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;
	
	import org.purepdf.Font;
	import org.purepdf.colors.RGBColor;
	import org.purepdf.elements.Chunk;
	import org.purepdf.elements.Element;
	import org.purepdf.elements.IElement;
	import org.purepdf.elements.Paragraph;
	import org.purepdf.elements.images.ImageElement;
	import org.purepdf.pdf.PdfDocument;
	import org.purepdf.pdf.PdfPCell;
	import org.purepdf.pdf.PdfPTable;
	import org.purepdf.pdf.PdfTextArray;
	
	public class AssessementPDF 
	{
		[Embed(source="/assets/check.png",mimeType="application/octet-stream")]
		private var checkEmbed:Class;
		[Embed(source="/assets/uncheck.png",mimeType="application/octet-stream")]
		private var uncheckEmbed:Class;
		[Embed(source="/assets/TRiggmat_header_pic.png",mimeType="application/octet-stream")]
		private var triggmatHeaderPicEmbed:Class;
		[Embed(source="/assets/Miljö_header_pic.png",mimeType="application/octet-stream")]
		private var miljoHeaderPicEmbed:Class;
		
		private var checkImg: ImageElement ;
		private var uncheckImg: ImageElement ;
		private var triggmatHeaderPic: ImageElement ;
		private var miljoHeaderPic: ImageElement ;
		private var lstTask:ArrayCollection;
		private var appItem:Object;
		private var document:PdfDocument;
		private var colorHeaderGrid:org.purepdf.colors.RGBColor = new org.purepdf.colors.RGBColor();
		private var colorROW:org.purepdf.colors.RGBColor = new org.purepdf.colors.RGBColor();
		private var colorBGPage:org.purepdf.colors.RGBColor = new org.purepdf.colors.RGBColor();
		private var colorBGData:org.purepdf.colors.RGBColor = new org.purepdf.colors.RGBColor();
		private var arrColorData:Array = new Array();
		private var arrColorPage:Array = new Array();
		private var arrColorHeaderGrid:Array = new Array();
		private var pdf:CustomPurePDF;
		private var bgColorHeaderGrid:Object = Preferences.BLACK;
		private var bgColorPage:Object = Preferences.WHITE;	
		private var bgColorData:Object = Preferences.RED;
		private var lstColumn:Array = new Array();
		private var colQuestionWidth:int = 16;
		private var colAnswerWidth:int = 2;
		private var colComment:int = 6;
		private var mapTask:Dictionary=null;
		private var model:DtoConfiguration;
		private var modelTotal:AssessmentModelTotal;
		private var accName:String ;
		private var amountShowedSection:int = 14;
		private var quesLimit:int = 35;
		private var maxline:int=38;
		private var paddingSecName:int = 8;
		
		private var colCheckboxWidth:int = 2;
		
		public function AssessementPDF(apptItem:Object,pdfSize:String = "PORTRAIT")
		{  
			var pdfHeader:String = " ";
			var rotat:Boolean = false;
			this.appItem = apptItem;
			accName = getAccountName(appItem);
			lstTask = Database.activityDao.findSurveyByParentSurveyId(appItem.ActivityId,Survey.ACTIVITY_TYPE);
			if(lstTask.length >0){
				model = getModel(lstTask[0]);
				if(model != null){
					loadImage();
					lstColumn = Database.mappingTableSettingDao.getColumnByModelId(model.recordId);
					
					bgColorHeaderGrid = Database.assessmentPDFColorThemeDao.getPDFColorByColorType(AssessmentPDFColorThemeDAO.IMG_BG_PDF_HEADER_COLOR_GRID);
					arrColorHeaderGrid = Utils.MAP_HEADER_COLOR_PDF[bgColorHeaderGrid];
					if(arrColorHeaderGrid == null){
						bgColorHeaderGrid = Preferences.BLACK;
						arrColorHeaderGrid = Utils.MAP_HEADER_COLOR_PDF[bgColorHeaderGrid];
						
					}
					bgColorData = Database.assessmentPDFColorThemeDao.getPDFColorByColorType(AssessmentPDFColorThemeDAO.IMG_BG_PDF_COLOR_DATA_HEADER);
					arrColorData = Utils.MAP_HEADER_COLOR_PDF[bgColorData];
					if(arrColorData == null){
						bgColorData = Preferences.LIGHT_GREEN;
						arrColorData = Utils.MAP_HEADER_COLOR_PDF[bgColorData];
						
					}
					
					bgColorPage = Database.assessmentPDFColorThemeDao.getPDFColorByColorType(AssessmentPDFColorThemeDAO.IMG_BG_PDF_COLOR_PAGE);
					arrColorPage =  Utils.MAP_HEADER_COLOR_PDF[bgColorPage];
					if(arrColorPage == null){
						bgColorPage = Preferences.WHITE;
						arrColorPage = Utils.MAP_HEADER_COLOR_PDF[bgColorPage];
						
					}
					
					colorBGPage.setValue(arrColorPage[0][0],arrColorPage[0][1],arrColorPage[0][2]);
					
					colorHeaderGrid.setValue(arrColorHeaderGrid[0][0],arrColorHeaderGrid[0][1],arrColorHeaderGrid[0][2]);
					
					
					
					if(model.assessmentModel=="KiB Miljö"){
						colorBGData.setValue(153, 204,0);
					}else if(model.assessmentModel=="KiB Tryggmat"){
						colorBGData.setValue(255,51,0);
					}else if(model.assessmentModel=="Foersaeljningsledare Butiks"){
						colorBGData.setValue(204,0,0);
						pdfHeader = "Butiksdialogen";
					}else{
						colorBGData.setValue(arrColorData[0][0],arrColorData[0][1],arrColorData[0][2]);
						pdfHeader= model.assessmentModel + " "+ getAccountName(appItem,false) +" "+ DateUtils.format(new Date(), DateUtils.getCurrentUserDatePattern().dateFormat);
					}
					
					
					
					
					colorROW.setValue(arrColorHeaderGrid[1][0],arrColorHeaderGrid[1][1],arrColorHeaderGrid[1][2]);
					if(pdfSize.toLocaleUpperCase()=="LANDSCAPE"){
						rotat = true;
						amountShowedSection = 8;
						quesLimit = 22;
						maxline = 25;
					}
					//Pdf Header Page
					pdf = new CustomPurePDF(pdfHeader);
					
					// --- create doc pdf first ---//
					document = pdf.createDocument(rotat,22,22,0,0);
					//document.setMargins(30,30,25,25);
				}
			}
			
		}
		private function getAccountName(appItem:Object,replaceSpace:Boolean=true):String{
			var name:String = "";
			var acc:Object = Utils.getAccount(appItem);
			if(acc!=null){
				name = Utils.getAccount(appItem).AccountName;
				if(replaceSpace){
					name =  name.replace(/ /gi,"_") + "_";
				}
				return name;
			}
			return "";
		}
		
		private var lineNumber:int = 0;
		
		
		protected function drawPageModel(pageTotal:AssessmentPageTotal):void{
			var font:org.purepdf.Font = CustomPurePDF.getUnicodeFont(10,org.purepdf.Font.BOLD);
			var pName:Paragraph = new Paragraph(pageTotal.getName(),font);			
			var tblPage:PdfPTable = new PdfPTable(1);
			tblPage.widthPercentage = 100;
			
			var isShowFirstTable:Boolean = true;
			//document.addElement(pName);
			tblPage.addCell(createCellSection(pName,colorBGPage,paddingSecName));
			var sectionTable: PdfPTable = new PdfPTable(getColumnCount());		
			tblPage.addCell(createCellSection(sectionTable,colorBGPage));	
			sectionTable.widthPercentage = 97;
			for each(var section:AssessmentSectionTotal in pageTotal.listSectionTotal){			
				var isButiks:Boolean = section.getDtoModel().assessmentModel == "Foersaeljningsledare Butiks";
				if((lineNumber+sectionTable.rows.length+section.listQuestion.length)>=maxline){
					//tblPage.addCell(createCellSection( new Paragraph("",font),colorBGPage));//new line
					//tblPage.addCell(createCellSection( new Paragraph("",font),colorBGPage));//new line
					document.addElement(tblPage);
					
					document.newPage();
					lineNumber =0;
					tblPage = new PdfPTable(1);
					tblPage.widthPercentage = 100;		
					tblPage.addCell(createCellSection(pName,colorBGPage,paddingSecName));
					if(!isButiks){
						sectionTable = new PdfPTable(getColumnCount());
						createHeaderSection(sectionTable,section, isButiks);
						tblPage.addCell(createCellSection(sectionTable,colorBGPage));	
						sectionTable.widthPercentage = 97;
					}
				}
				//newLine();
				//createQuesTable(section);
				
				if(isShowFirstTable){
					tblPage.addCell(createCellSection( new Paragraph("",font),colorBGPage));//new line
					createHeaderSection(sectionTable,section, isButiks);
				}else if(isButiks)
				{
					lineNumber +=sectionTable.rows.length;						
					sectionTable = new PdfPTable(getColumnCount());
					sectionTable.widthPercentage = 97;
					createHeaderSection(sectionTable,section, isButiks);
					tblPage.addCell(createCellSection(sectionTable,colorBGPage));	
					sectionTable.widthPercentage = 97;
				}
				createQuesTable(sectionTable,section);
				
				isShowFirstTable = false;
				
			}
			
			//newLine();
			tblPage.addCell(createCellSection(new Paragraph("",font),colorBGPage));  //new line
			tblPage.addCell(createCellSection(createTotalTable(i18n._("ASSESSMENT_PAGE_TOTAL@Page Total"),pageTotal),colorBGPage));
		
			document.addElement(tblPage);
		}
		
		public function generatePDF():int{
			
			var isFirstPage:Boolean = true;
			if(model==null || lstTask.length <= 0) return 0;
			
			modelTotal = new AssessmentModelTotal(model);
			for each(var pageName:String in model.pageSelectedIds){						
				var page:DtoPage = Database.assessmentPageDao.selectByPageName(pageName);						
				var pageTotal:AssessmentPageTotal = new AssessmentPageTotal(page);
				modelTotal.addPageTotal(pageTotal);	
				if(page!=null){
					for each(var assId:String in page.assessmentSelectedIds){
						bindListQuestion(assId,pageTotal);
					}
					
				}
			}
			
			
			
			HeaderDataTable();
			
			newLine();
			
			
			if(modelTotal.listPageTotal.length>0){
				//show grand total
				newLine();
				document.addElement(createTotalTable(i18n._("MODEL_TOTAL@Model Total"),modelTotal,true));
				newLine();
			}
						
			var pageIndex:int =0;
			
			for each(var pageTotalA:AssessmentPageTotal in modelTotal.listPageTotal){
				drawPageModel(pageTotalA);
				if(pageIndex < modelTotal.listPageTotal.length-1){
					lineNumber=0;
					document.newPage();
				}
				pageIndex ++ ;
			}
			
			
			
			
			document.close();
			///removeAttachment(model.assessmentModel ,appItem.gadget_id);
			var file:File =Utils.writeFile( model.assessmentModel + "_" + accName + DateUtils.getCurrentDateAsSerial() +".pdf", pdf.getByteArray() ); // generate pdf
			file.openWithDefaultApplication();
			
			attachPDFToAppointment(file,model.assessmentModel + "_" + accName +  DateUtils.format(new Date(), "MM.YYYY") +".pdf");
			return lstTask.length;
		}
		
		private function createTableAccount(tbl:PdfPTable,colDisplay:int,colField:int):void{
			
			var fld:String = FieldUtils.getField(Database.accountDao.entity,"IndexedPick5").display_name;
			var fld2:String = FieldUtils.getField(Database.accountDao.entity,"CustomPickList6").display_name;
			var acc:Object = Database.accountDao.getAccountById(appItem.AccountId);
			tbl.widthPercentage = 97;
			if(model.assessmentModel=="KiB Miljö"){
				tbl.addCell(createCell(fld,colDisplay,true,colorBGData,Element.ALIGN_RIGHT,false,RGBColor.WHITE));
				tbl.addCell(createCell(acc["IndexedPick5"],colField-colDisplay));
			}
			if(model.assessmentModel=="KiB Tryggmat"){
				tbl.addCell(createCell(fld2,colDisplay,true,colorBGData,Element.ALIGN_RIGHT,false,RGBColor.WHITE));
				tbl.addCell(createCell(acc["CustomPickList6"],colField-colDisplay));
			}
			
			
		}
		
		private function createCellSection(obj:IElement,color:RGBColor,paddingLeft:int=0):PdfPCell{
			var cell:PdfPCell = new PdfPCell();
			cell.border = 0;
			cell.paddingLeft = paddingLeft;
			cell.backgroundColor = color;
			cell.addElement(obj);
			return cell;
		}
		private function getModel(task:Object):DtoConfiguration{
			return Database.assessmentConfigDao.getAssessmentConfigByName(String(task.ActivitySubType));
		}
		private function bindListQuestion(assId:String,pageTotal:AssessmentPageTotal):void{
			
			var ass:Object = Database.assessmentDao.getById(assId);			
			if(ass==null){
				return ;//missing assessment in the db
			}
			var lstQues:Array = Database.questionDao.getByAssessmentName(ass.Name);
			var task:Object = getTask(ass.Name,pageTotal.page.pageName);				
			var sectionTotal:AssessmentSectionTotal = new AssessmentSectionTotal(ass);
			pageTotal.addSectionTotal(sectionTotal);					
			var odd:Boolean = false;
			if(lstQues!=null && lstQues.length>0){
				var listColumns:Array = Database.mappingTableSettingDao.getColumnByModelId(model.recordId);
				
				for each(var quest:Object in lstQues){
					//clear question default value
					for each(var dtoCol:DtoColumn in listColumns){
						if (dtoCol.colProperty != "Question" ){
							delete quest[dtoCol.colProperty];
						}
					}
					
					quest.RemoveCommentBox = quest.RemoveComment;
					quest.isHeader = false;
					quest.odd =  odd ? false : true;
					quest.gadget_id = task == null ? null : task.gadget_id;
					
					odd = !odd;
					var mapCols:ArrayCollection = Database.assessmentMappingDao.selectByQuestionId(quest.QuestionId,model.recordId);
					if(task!=null){
						for each(var map:Object in mapCols){
							if (map.ColumnProperty != "Question" ){
								quest[map.ColumnProperty] = task[map.Oraclefield];
							}
						}
					}
					
				}		
				sectionTotal.listQuestion =new ArrayCollection(lstQues);
			}
			
			
			
		}
		
		private function getTask(assementName:String,pagename:String):Object{
			var task:Object = null;
			if(mapTask==null){
				mapTask = new Dictionary();
				
				for each(task in lstTask){		
					var key:String = task.Subject;
					if(task[ActivityDAO.ASS_PAGE_NAME]){
						key =key+task[ActivityDAO.ASS_PAGE_NAME];
					}
					mapTask[key] = task;
				}
			}
			
			task =  mapTask[assementName+pagename];
			
			if(task==null){
				//maybe get from ood so pagname is empty
				//try get task with assname
				task = mapTask[assementName];
			}
			
			return task;
		}
		
		private function removeAttachment(fileName:String,parentId:String):void{
			Database.attachmentDao.deleteByFileName(fileName,parentId);
		}
		private function createQuesTable(table: PdfPTable,section:AssessmentSectionTotal):void {
			var odd:Boolean = false;
			
			colorROW.setValue(arrColorHeaderGrid[1][0],arrColorHeaderGrid[1][1],arrColorHeaderGrid[1][2]);
			
			for each(var q:Object in section.listQuestion){
				var isHeader:Boolean = true;
				for each(var col:DtoColumn in lstColumn){
					if(!col.visible) continue;
					if(col.colProperty == 'Question'){
						if((model.assessmentModel=="KiB Miljö" || model.assessmentModel=="KiB Tryggmat") && q["backgroundColor"]=="1" && isHeader){
							table.addCell(createCell(q[col.colProperty], getColumnCount(), true, RGBColor.GRAY, Element.ALIGN_LEFT, true));
							isHeader = false;
						}
						table.addCell(createCell(q[col.colProperty],colQuestionWidth,odd,colorROW));
					}else if(col.isCheckbox || col.dataType ==DtoColumn.RADIO_TYPE){
						table.addCell(createCell(q[col.colProperty] == 1 || q[col.colProperty] == "true" ? "Check":"Uncheck", colCheckboxWidth ,odd,colorROW));
					}else{
						table.addCell(createCell(q[col.colProperty],colComment,odd,colorROW));
					}
				}
				
				odd = odd ? false : true;
			}
			//			if(section.assessment.Name== "B- 2 Sortiment- 3 Marginal"){
			//				for each(var col:DtoColumn in lstColumn){
			//					if(!col.visible) continue;
			//					if(col.colProperty == 'Question'){
			//						table.addCell(createCell("Test",colQuestionWidth,odd,colorROW));
			//					}else if(col.isCheckbox){
			//						table.addCell(createCell(1 == 1 || q[col.colProperty] == "true" ? "Check":"Uncheck",colAnswerWidth ,odd,colorROW));
			//					}else{
			//						table.addCell(createCell("test",colComment,odd,colorROW));
			//					}
			//				}
			//			}
			//Show total section
			if(section.listQuestion.length > 1){ // don't show total percent equal one question
				for each(var col1:DtoColumn in lstColumn){
					if(col1.colProperty == 'Question'){
						table.addCell(createCell(i18n._("Total@Total"),colQuestionWidth ,odd,colorROW));
					}else if(col1.isHasSumField){
						var pdfCell:PdfPCell = createCell(getDisplayTotal(section.getPercentTotal(col1),model.sumType),colAnswerWidth ,odd,colorROW,Element.ALIGN_CENTER);
						pdfCell.paddingLeft = section.getPercentTotal(col1) == 100 ? 6 : 9;
						table.addCell(pdfCell);
					}else if(col1.visible){
						table.addCell(createCell("",colComment ,odd,colorROW));
					}
				}
			}			
			//document.addElement(table);
			// return table;
		}
		
		private function createHeaderSection(table: PdfPTable,section:AssessmentSectionTotal, isButiks:Boolean=false):void{
			
			//colorHeader.setValue(145,145,254);
			//colorHeaderGrid.setValue(arrColorHeaderGrid[0][0],arrColorHeaderGrid[0][1],arrColorHeaderGrid[0][2]);
			for each(var col:DtoColumn in lstColumn){
				if(!col.visible) continue;
				if(col.colProperty == 'Question'){
					table.addCell(createCell(isButiks?section.assessment.Name : "",colQuestionWidth,true,colorHeaderGrid,Element.ALIGN_LEFT,true,RGBColor.WHITE));
				}else if(col.isCheckbox || col.dataType == DtoColumn.RADIO_TYPE){
					table.addCell(createCell(col.title, colCheckboxWidth ,true,colorHeaderGrid,Element.ALIGN_LEFT,true,RGBColor.WHITE));
				}else {
					table.addCell(createCell(col.title,colComment,true,colorHeaderGrid,Element.ALIGN_LEFT,true,RGBColor.WHITE));
				}
			}
		}
		
		private function HeaderDataTable():void{
			var tblCustomText: PdfPTable = new PdfPTable(1);
			var table: PdfPTable = new PdfPTable(8);
			var customText:String = " ";
			table.widthPercentage = 97;
			tblCustomText.widthPercentage = 100;
			var listHeader:ArrayCollection = Database.assessmentPDFHeaderDao.getAllPDFHeader(model.recordId);
			for each(var obj:DtoAssessmentPDFHeader in listHeader){
				if(obj.isCustomText){
					if(!StringUtils.isEmpty(obj.customText)){
						customText = obj.customText;
						if(model.assessmentModel=="KiB Miljö"){
							tblCustomText.addCell(createImageCell("KiB Miljö"));
						}else if(model.assessmentModel=="KiB Tryggmat"){
							tblCustomText.addCell(createImageCell("KiB Tryggmat"));
						}else{
							tblCustomText.addCell(createCell(customText,1,true,colorHeaderGrid,Element.ALIGN_CENTER,true,RGBColor.WHITE));
						}
						document.addElement(tblCustomText);
						lineNumber +=tblCustomText.rows.length;
						newLine();
					}
					
					
				}
				else
				{
					var field:Object = Database.fieldDao.findFieldByPrimaryKey(obj.entity,obj.elementName);
					var item:Object
					
					if(field != null){
						if(obj.entity == "Account"){
							item = Database.accountDao.getAccountById(appItem.AccountId);
						}else if(obj.entity == "Contact"){
							item = Database.contactDao.getContactById(appItem.PrimaryContactId);
						}else{
							item = appItem;
						}
						
						if(field.data_type == "Picklist"){
							var picklist:ArrayCollection = PicklistService.getPicklist(field.entity, field.element_name);
							item[field.element_name] = getSelectedItem(item[field.element_name], picklist);
						}
						
						
						if(item != null){
							table.addCell(createCell(StringUtils.isEmpty(obj.display_name) ? field.display_name : obj.display_name,3,true,colorBGData,Element.ALIGN_RIGHT,false,RGBColor.WHITE));
							table.addCell(createCell(item[field.element_name] == null ? "" : getValue(item,field),5));
						}
					}
				}
			}
			lineNumber += table.rows.length;
			document.addElement(table);
		}
		
		private function getSelectedItem(value:String, arrayCollection:ArrayCollection, property:String="data", propertyResult:String="label", defaultResult:String=""):String{
			for each(var item:Object in arrayCollection){
				if(item[property] == value){
					return item[propertyResult];
				}
			}
			return defaultResult;
		}
		
		private function getValue(item:Object,field:Object):String{
			var val:String = item[field.element_name];
			var dformater:DateFormatter = new DateFormatter();
			var datePattern:Object = DateUtils.getCurrentUserDatePattern();
			dformater.formatString = datePattern.dateFormat;
			if(field.data_type=="Date" ||field.data_type=="Date/Time"){
				
				if(!StringUtils.isEmpty(val)){
					var	tmpDateTime:Date=DateUtils.guessAndParse(val);
					val = dformater.format(tmpDateTime);
					if(field.data_type=="Date/Time" && field.element_name!="StartTime"){
						val += " "+tmpDateTime.getHours() + ":"+tmpDateTime.getMinutes();
					}
				}
				
			}
			
			return val;
			
		}
		
		
		private function createTotalTable(title:String,dto:IAssessmentTotal,isModelTotal:Boolean=false):PdfPTable{		
			
			
			
			var color:RGBColor = colorHeaderGrid;
			var lstSumField:Array = Database.sumFieldDao.getAllSumField(model.recordId);
			var percentSign:String = "";
			
			var colModelTotalWidth:int = 0;
			
			if(isModelTotal && (dto.getModel().assessmentModel == "KiB Miljö" || dto.getModel().assessmentModel == "KiB Tryggmat")){
				colModelTotalWidth = 14;
			}
			
			
			if(lstSumField != null && lstSumField.length > 0){
				var cols:int = (lstSumField.length * colAnswerWidth )+colQuestionWidth + colModelTotalWidth;
				var table: PdfPTable = new PdfPTable(cols);
				
				if(isModelTotal){
					color = colorBGData;
					table.widthPercentage = 100;
					table.addCell(createCell("",colQuestionWidth,true,color,Element.ALIGN_LEFT,true,RGBColor.WHITE));
				}else{
					table.widthPercentage = 97;
					table.addCell(createCell(title,colQuestionWidth,true,color,Element.ALIGN_LEFT,true,RGBColor.WHITE));
				}
				
				for each(var dtoSumCol:Object in lstSumField){
					var mappingObject:DtoColumn = Database.mappingTableSettingDao.selectByGadgetId(dtoSumCol.ColId);
					if(mappingObject!=null){
						table.addCell(createCell(mappingObject.title,colAnswerWidth,true,color,Element.ALIGN_LEFT,true,RGBColor.WHITE));
					}
				}
				if(!isModelTotal){
					color = colorROW;
					percentSign = "%";
				}else if(colModelTotalWidth > 0){
					// Add descrition
					
					table.addCell(createCellDescription(lstSumField, colModelTotalWidth, true, color, RGBColor.WHITE));
					
					
					/*
					var description:String = "";
					for each(var dtoSCol:Object in lstSumField){
						var dtoColumn:DtoColumn = Database.mappingTableSettingDao.selectByGadgetId(dtoSCol.ColId);
						if(dtoColumn!=null && !StringUtils.isEmpty(dtoColumn.description)){
							if(description.length > 0) description += ", ";
							description += dtoColumn.title + ": " + dtoColumn.description;
						}
					}
					if(description.length > 0) description += ".";
					table.addCell(createCell(description, colModelTotalWidth, true, color, Element.ALIGN_LEFT, false, RGBColor.WHITE));
					*/
				}
				
				
				if(!isModelTotal){
					table.addCell(createCell("",colQuestionWidth,true,color,isModelTotal ? Element.ALIGN_RIGHT : Element.ALIGN_LEFT,false, isModelTotal ? RGBColor.WHITE : RGBColor.BLACK));
				}else{
					table.addCell(createCell(i18n._("GLOBAL_TOTAL_MODEL"),colQuestionWidth,true,color,isModelTotal ? Element.ALIGN_RIGHT : Element.ALIGN_LEFT,false, isModelTotal ? RGBColor.WHITE : RGBColor.BLACK));
				}
				
				
				
				for each(var dtoSum:Object in lstSumField){
					var mappingObj:DtoColumn = Database.mappingTableSettingDao.selectByGadgetId(dtoSum.ColId);
					if(mappingObj!=null){
						table.addCell(createCell(getDisplayTotal(dto.getPercentTotal(mappingObj),model.sumType) ,colAnswerWidth,true,colorROW,Element.ALIGN_LEFT,false));
					}
				}
				if(isModelTotal){
					if(colModelTotalWidth > 0){
						table.addCell(createCell("",colModelTotalWidth));
					}
					createTableAccount(table,colQuestionWidth,cols);
				}
				lineNumber+=table.rows.length;
				return table;
			}
			return null;
		}
		private function getDisplayTotal(total:Number,typ:String):String{
			if(model.assessmentModel=="KiB Miljö" || model.assessmentModel=="KiB Tryggmat"){
				return total+"";
			}
			
			if( StringUtils.isEmpty(typ)){
				return total.toFixed(2)+"";
			}
			return total.toFixed(2);
		} 
		
		private function createImageCell(typ:String):PdfPCell{
			var font:org.purepdf.Font = CustomPurePDF.getUnicodeFont(9,org.purepdf.Font.NORMAL);
			
			var cellValue:PdfPCell = new PdfPCell();
			cellValue.border = 0;
			if(typ == "KiB Miljö"){
				miljoHeaderPic.alignment = Element.ALIGN_CENTER;
				cellValue.addElement(miljoHeaderPic);
			}else{
				triggmatHeaderPic.alignment = Element.ALIGN_CENTER;
				cellValue.addElement(triggmatHeaderPic);
			}
			
			
			
			return cellValue;
		}
		
		private function createCellDescription(lstSumField:Array, colspan:int=1, hasColor:Boolean=false,color:RGBColor=null, forColor:RGBColor = RGBColor.BLACK):PdfPCell{
			var endPoint:int = 0;
			for each(var dtoSCol:Object in lstSumField){
				var dtoColumn:DtoColumn = Database.mappingTableSettingDao.selectByGadgetId(dtoSCol.ColId);
				if(dtoColumn!=null && !StringUtils.isEmpty(dtoColumn.description)){
					endPoint ++;
				}
			}
			
			var cellValue:PdfPCell = new PdfPCell();
			var font:org.purepdf.Font = CustomPurePDF.getUnicodeFont(9,org.purepdf.Font.NORMAL);
			var fontBold:org.purepdf.Font = CustomPurePDF.getUnicodeFont(9,org.purepdf.Font.BOLD);
			var index:int = 0;
			
			font.color = forColor;
			fontBold.color = forColor;
			var mainLabel:Paragraph = new Paragraph("", null);
			for each(dtoSCol in lstSumField){
				dtoColumn = Database.mappingTableSettingDao.selectByGadgetId(dtoSCol.ColId);
				if(dtoColumn!=null && !StringUtils.isEmpty(dtoColumn.description)){
					var chunkB:Chunk = new Chunk(dtoColumn.title, fontBold);
					var chunk:Chunk = new Chunk(": " + dtoColumn.description + ( index == (endPoint-1) ? "." : ", "), font);
					mainLabel.add(chunkB);
					mainLabel.add(chunk);
					index ++;
				}
			}
			cellValue.addElement(mainLabel);
			cellValue.colspan = colspan;
			if(hasColor) {
				cellValue.backgroundColor = color;
			}else{
				color = new org.purepdf.colors.RGBColor();
				color.setValue(255,255,255);
				cellValue.backgroundColor = color;
			}
			return cellValue;
		}
		
		private function createCell(content:String,colspan:int=1,hasColor:Boolean=false,color:RGBColor=null,align:int=Element.ALIGN_LEFT,isHeader:Boolean=false,forColor:RGBColor = RGBColor.BLACK):PdfPCell{
			var font:org.purepdf.Font = CustomPurePDF.getUnicodeFont(9,org.purepdf.Font.NORMAL);
			if(isHeader){
				font = CustomPurePDF.getUnicodeFont(10,org.purepdf.Font.BOLD);
			}
			var label:Paragraph = new Paragraph(content,font);
			var cellValue:PdfPCell = new PdfPCell();
			//			if(isHeader && (bgColorHeaderGrid == Preferences.DARK_BLUE || bgColorHeaderGrid == Preferences.BLACK )) {
			//				font.color = RGBColor.WHITE;
			//			}else{
			//				font.color = RGBColor.BLACK;
			//			}
			font.color = forColor;
			
			if(content == "Check"){
				checkImg.alignment = Element.ALIGN_CENTER;
				cellValue.addElement(checkImg);
				
			}else if(content == "Uncheck"){
				uncheckImg.alignment = Element.ALIGN_CENTER;
				cellValue.addElement(uncheckImg);
			}
			else{
				label.alignment = align;
				cellValue.addElement(label);
				//cellValue.horizontalAlignment = align;
				//if(isHeader && align == 1) cellValue.paddingLeft = 7;
			}
			
			cellValue.colspan = colspan;
			if(hasColor) {
				cellValue.backgroundColor = color;
			}else{
				color = new org.purepdf.colors.RGBColor();
				color.setValue(255,255,255);
				cellValue.backgroundColor = color;
			}
			return cellValue;
		}
		
		private function newLine():void{
			
			var table: PdfPTable = new PdfPTable(1);
			var cell:PdfPCell = new PdfPCell();
			var val:Paragraph = new Paragraph("7777");
			cell.border = 0;
			//cell.addElement(img);
			table.widthPercentage = 100;
			table.addCell(cell);
			table.addCell(cell);
			document.addElement(table);
			lineNumber+=2;			
		}
		private function loadImage():void{
			checkImg = ImageElement.getInstance(new checkEmbed());
			checkImg.scaleToFit(10,10);
			uncheckImg = ImageElement.getInstance(new uncheckEmbed());
			uncheckImg.scaleToFit(10,10);
			
			miljoHeaderPic = ImageElement.getInstance(new miljoHeaderPicEmbed());
			
			triggmatHeaderPic = ImageElement.getInstance(new triggmatHeaderPicEmbed());
		}
		
		private function attachPDFToAppointment(file:File,filename:String = null):void{
			var obj:Object = Database.getDao(Database.activityDao.entity).findByOracleId(appItem.ActivityId);
			if(obj != null){
				Utils.upload(file, Database.activityDao.entity, obj.gadget_id,null,null,filename);
				//Bug #6458: 1.303 Survey Sync Issue
				//obj.Status = "Completed";
				obj.local_update = new Date().getTime();
				Database.getDao(Database.activityDao.entity).update(obj);
				
			}
		}
		
		private function getColumnCount():int{
			var colCount:int =0;
			for(var i:int;i<lstColumn.length;i++){
				var col:DtoColumn = lstColumn[i];
				if(!col.visible) continue;
				if(col.isCheckbox || col.dataType == DtoColumn.RADIO_TYPE){
					colCount += colCheckboxWidth; 
				}else if(col.colProperty != 'Question'){
					colCount += colComment;
				}
			}
			colCount += colQuestionWidth;
			
			return colCount;
		}
		
	}
}