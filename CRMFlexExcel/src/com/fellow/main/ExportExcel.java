package com.fellow.main;

import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xssf.usermodel.extensions.XSSFCellBorder.BorderSide;

import com.fellow.dto.DtoColumn;
import com.fellow.dto.DtoHeaders;
import com.fellow.dto.DtoModel;
import com.fellow.dto.DtoModelTotal;
import com.fellow.dto.DtoPageTotal;
import com.fellow.dto.DtoPages;
import com.fellow.dto.DtoRow;
import com.fellow.dto.DtoSections;




public class ExportExcel {
	protected static final short SHEET_EXPORT = 0;
	private XSSFWorkbook workBook = null;
	private XSSFSheet sheet = null;
	private XSSFCellStyle styleGrey =null;
	private XSSFCellStyle styleBlack = null;
	private XSSFCellStyle styleGreen = null;
	private XSSFCellStyle styleNomal =null;
	
	private boolean isFoersaeljningsledare = false;
	
	private String template_name = "";
	public void exportExcel(String fpath){
//		fpath ="C:/Users/ASUS/Desktop/test.xml";
		//fpath = "C:\Users\ASUS\AppData\Local\Temp\flaA67E.tmp\KiB Tryggmat_ICA_Nära_Duvbo_2014.06.19.11.38.27.xml";
//		fpath = fpath.replaceAll("\\", "/");
		File f = new File(fpath);
		File folder = f.getParentFile();
		//DataOutputStream dataOutputStream = new DataOutputStream(System.out);
		
		try{
			
			ByteArrayOutputStream out=new ByteArrayOutputStream();
	        DtoModel dtoModel = (DtoModel) loadData(DtoModel.class, fpath);  
	        Color color = null;
			if("KiB Miljö".equalsIgnoreCase(dtoModel.getTitle())){
				template_name = "Miljo.xlsx";
				color = new Color(153,204,0);
			}else if("Foersaeljningsledare Butiks".equalsIgnoreCase(dtoModel.getTitle())){
				template_name = "Foersaeljningsledare.xlsx";
				isFoersaeljningsledare = true;
				color = new Color(204,0,0);
			}else if("KiB Tryggmat".equalsIgnoreCase(dtoModel.getTitle())){
				template_name = "Tryggmat.xlsx";
				color = new Color(255,51,0);
			}
			workBook =  getWorkBook();
			if(workBook != null){
			
				sheet = getSheet(workBook);
				//XSSFCellStyle style=workBook.createCellStyle();
				//style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
				int startRow = 2;
				
				
				
				// styleGreen = header color of table
				styleGreen = createFillBackGroundColor(workBook, new XSSFColor(color), null);
				
				XSSFFont font = workBook.createFont();
				font.setFontName(XSSFFont.DEFAULT_FONT_NAME);
			    //font.setFontHeightInPoints((short)10);
			    font.setColor(IndexedColors.WHITE.getIndex());
			    styleGreen.setFont(font);
			    styleGreen.setAlignment(HorizontalAlignment.RIGHT);
			    styleGreen.setVerticalAlignment(VerticalAlignment.CENTER);
			    
				styleGrey = createFillBackGroundColor(workBook, new XSSFColor(new Color(192,192,192)), null);
				styleBlack = createFillBackGroundColor(workBook, new XSSFColor(new Color(0,0,0)), null);
				styleNomal = (XSSFCellStyle)workBook.createCellStyle();
				styleNomal.setAlignment(HorizontalAlignment.LEFT);
				styleGrey.setAlignment(HorizontalAlignment.LEFT);
				setCellBorder(styleGreen);
				setCellBorder(styleGrey);
				setCellBorder(styleNomal);
				setCellBorder(styleBlack);
				    
				startRow = createTableHeader(dtoModel,startRow);
				
				// sum field
				
				startRow = startRow+  1;
				startRow = createModelTotal(dtoModel,startRow) + 1;
				// create page
				
				createPageSection(dtoModel,startRow);
				
			}
			
			workBook.write(out);
			
			/*dataOutputStream.write(out.toByteArray());

			 dataOutputStream.flush();

			 dataOutputStream.close();*/
			// String s = new String(out.toByteArray(),"UTF-8");
			
		//	String content = new String(Base64.encodeBase64(out.toByteArray()));
//			System.out.println(content);
			
			/*File file = new File(folder,"C:/Users/ASUS/Desktop/Test.xlsx");
			FileOutputStream nfiel = new FileOutputStream(file);
			nfiel.write(out.toByteArray());*/
			
			String fName = f.getName().replace("xml", "xlsx");
			File file = new File(folder,fName);
			FileOutputStream nfiel = new FileOutputStream(file);
			nfiel.write(out.toByteArray());
			out.close();
			//byte[] theByteArray = stringToConvert.getBytes();    

			/*DataOutputStream dataOutputStream = new DataOutputStream(System.out);

			dataOutputStream.write(out.toByteArray());

			dataOutputStream.flush();   */
			System.out.println(file.getAbsolutePath().replaceAll("\\\\", "/"));
//			System.out.println(fName);
		}catch(Exception e){
			/*final Writer result = new StringWriter();
			final PrintWriter printWriter = new PrintWriter(result);
			e.printStackTrace(printWriter);*/

			//System.out.println("Error: "+fpath+"," + result.toString());
			throw new RuntimeException(e);
		}

	}
	private void setCellBorder(XSSFCellStyle style){
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);             
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);            
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);              
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        
		style.setBorderColor(BorderSide.LEFT,new XSSFColor(new Color(0,0,0)));
		style.setBorderColor(BorderSide.RIGHT,new XSSFColor(new Color(0,0,0)));
		style.setBorderColor(BorderSide.TOP,new XSSFColor(new Color(0,0,0)));
		style.setBorderColor(BorderSide.BOTTOM,new XSSFColor(new Color(0,0,0)));
	}
	private int createModelTotal(DtoModel dtoModel,int startRow){
		XSSFCellStyle style = null;
		DtoModelTotal modelTotal = dtoModel.getModelTotal();
		if(modelTotal != null && modelTotal.getRows() != null && modelTotal.getRows().size()>0){
			
			int startCol = 0;
			int endCol = 0;
			if(isFoersaeljningsledare){
				endCol = 8;
			}
			int indRow = 0;
			for(DtoRow row : modelTotal.getRows()){
				XSSFRow qRow=sheet.getRow(startRow);
				if(qRow == null){
					qRow=sheet.createRow(startRow);
				}
				if(indRow == 0){
					if(!isFoersaeljningsledare){
						qRow.setHeight((short)(qRow.getHeight()*3));
					}
					
					
					style = (XSSFCellStyle)styleGreen.clone();
					
					fillCell(qRow, 0,"", XSSFCell.CELL_TYPE_STRING, true,styleGreen);
					style.setAlignment(HorizontalAlignment.LEFT);
					
					
					
				}else if(indRow == 1){
					style = (XSSFCellStyle)styleGrey.clone();
//					style.setAlignment(HorizontalAlignment.LEFT);
					fillCell(qRow, 0,row.getTitle(), XSSFCell.CELL_TYPE_STRING, true,styleGreen);
				}
				if(indRow == 2){
					
					sheet.addMergedRegion(new CellRangeAddress(startRow, startRow, 1, 9));
					fillCell(qRow, 0,row.getTitle(), XSSFCell.CELL_TYPE_STRING, true,styleGreen);
					//style.setAlignment(HorizontalAlignment.LEFT);
					style = null;
				}else{
					if(!isFoersaeljningsledare){
						sheet.addMergedRegion(new CellRangeAddress(startRow, startRow, 6, 9));
					}
					
				}
				
				sheet.addMergedRegion(new CellRangeAddress(startRow, startRow, startCol, endCol));
				List<DtoColumn> cols = row.getColumns();
				int c = endCol+1;
				if(cols != null && cols.size()>0){
					for(DtoColumn col : cols){
						fillCell(qRow, c,col.getValue(), XSSFCell.CELL_TYPE_STRING, true,style);
						
						c++;
					}
				}
				indRow++;
				startRow++;
			}
		}
		sheet.addMergedRegion(new CellRangeAddress(startRow, startRow, 0, 9));
		return startRow;
	}
	private int createPageSection(DtoModel dtoModel,int startRow){
		List<DtoPages> pages = dtoModel.getPages();
		if(pages != null && pages.size()>0){
			
			XSSFCellStyle style = null;
			
			for(DtoPages page : pages){
				
				XSSFRow row=sheet.getRow(startRow);
				if(row == null){
					row=sheet.createRow(startRow);
				}
				sheet.addMergedRegion(new CellRangeAddress(startRow, startRow, 0, 9));
				fillCell(row, 0, page.getTitle(), XSSFCell.CELL_TYPE_STRING, true,styleNomal);
				
				startRow++;
				
				List<DtoSections> sections = page.getSections();
				if(sections != null && sections.size()>0){
					for(DtoSections dtoSect : sections){
						
						
						List<DtoRow> dtoRow = dtoSect.getRows();
						if(dtoRow != null && dtoRow.size()>0){
							for(DtoRow r : dtoRow){
								
								List<DtoColumn> lstQ = r.getColumns();
								XSSFRow qRow=sheet.getRow(startRow);
								if(qRow == null){
									qRow=sheet.createRow(startRow);
								}
								if(r.isHeader()){
									
									style = (XSSFCellStyle)styleBlack.clone();
									XSSFFont font = workBook.createFont();
									font.setFontName(XSSFFont.DEFAULT_FONT_NAME);
								    //font.setFontHeightInPoints((short)10);
								    font.setColor(IndexedColors.WHITE.getIndex());
									
								     style.setFont(font);
								}else if(!r.isOdd()){
									style = (XSSFCellStyle)styleGrey.clone();
								}else{
									style = styleNomal;
								}
								int c = 1;
								if(r.getColspan()>0){
									style = (XSSFCellStyle)styleGrey.clone();
									sheet.addMergedRegion(new CellRangeAddress(startRow,startRow,0,r.getColspan()));
								}else if(isFoersaeljningsledare){
									sheet.addMergedRegion(new CellRangeAddress(startRow,startRow,0,6));
									sheet.addMergedRegion(new CellRangeAddress(startRow,startRow,8,9));
									c=7;
								}
								fillCell(qRow, 0, r.getTitle(), XSSFCell.CELL_TYPE_STRING, true, style);
								
								if(lstQ != null && lstQ.size()>0){
									for(DtoColumn colQ : lstQ){
										boolean lock = true;
										int cellStyle = XSSFCell.CELL_TYPE_STRING;
										try{
											Double.parseDouble(colQ.getValue());
											cellStyle = XSSFCell.CELL_TYPE_NUMERIC;
										}catch(NumberFormatException nfe){
											if(!isFoersaeljningsledare && c > 6 && r.isHeader()==false){
												
												lock = false;
												style = styleNomal;
												
											}
											
										}
										fillCell(qRow, c, colQ.getValue(), cellStyle, lock,style);
										c++;
									}
								}
								startRow ++;
								
							}
						}
						
					}
					
				}
				sheet.addMergedRegion(new CellRangeAddress(startRow, startRow, 0, 9));
				startRow = startRow + 1;
				createPageTotal(page,startRow);
				sheet.addMergedRegion(new CellRangeAddress(startRow+2, startRow+2, 0, 9));
				startRow = startRow + 3;
			}
			
		}
		return startRow;
	}
	private void createPageTotal(DtoPages page,int startRow){
//		XSSFCellStyle styleBlack = createFillBackGroundColor(workBook, new XSSFColor(new Color(0,0,0)), null);
		XSSFCellStyle style = null;
		DtoPageTotal pageTotal = page.getPageTotal();
		if(pageTotal != null && pageTotal.getRows()!= null && pageTotal.getRows().size()>0){
			
			for(DtoRow row : pageTotal.getRows()){
				int c=5;
				if(isFoersaeljningsledare){
					sheet.addMergedRegion(new CellRangeAddress(startRow, startRow, 0, 8));
					c = 9;
				}else{
					sheet.addMergedRegion(new CellRangeAddress(startRow, startRow, 0, 4));
				}

				XSSFRow qRow=sheet.getRow(startRow);
				if(qRow == null){
					qRow=sheet.createRow(startRow);
				}
				if(StringUtils.isNotBlank(row.getTitle())){
					style = (XSSFCellStyle)styleBlack.clone();
					XSSFFont font = workBook.createFont();
					font.setFontName(XSSFFont.DEFAULT_FONT_NAME);
				    //font.setFontHeightInPoints((short)10);
				    font.setColor(IndexedColors.WHITE.getIndex());
					
				    style.setFont(font);
					fillCell(qRow, 0, row.getTitle(), XSSFCell.CELL_TYPE_STRING, true, style);
				}else{
					style = styleGrey;
					fillCell(qRow, 0, "", XSSFCell.CELL_TYPE_STRING, true, style);
				}
				
				
				
				for(DtoColumn col : row.getColumns()){
					fillCell(qRow, c, col.getValue(), XSSFCell.CELL_TYPE_STRING, true, style);
					c++;
				}
				startRow++;
				
			}
			
		}
	}
	private int createTableHeader(DtoModel dtoModel,int startRow){
		DtoHeaders header = dtoModel.getHeader();
		
		if(isFoersaeljningsledare && StringUtils.isNotBlank(header.getTitle())){
			sheet.addMergedRegion(new CellRangeAddress(2, 2, 0, 9));
		    sheet.addMergedRegion(new CellRangeAddress(3, 3, 0, 9));
			// replace title
			XSSFRow row=sheet.getRow(2);
			if(row == null){
				row=sheet.createRow(2);
			}
			XSSFCellStyle style =  (XSSFCellStyle)styleBlack.clone();
			XSSFFont font = workBook.createFont();
			font.setFontName(XSSFFont.DEFAULT_FONT_NAME);
			font.setBold(true);
		    //font.setFontHeightInPoints((short)10);
		    font.setColor(IndexedColors.WHITE.getIndex());
		    style.setFont(font);
		    style.setAlignment(HorizontalAlignment.CENTER);
		    
			fillCell(row, 0, header.getTitle(), XSSFCell.CELL_TYPE_STRING, true,style);
			startRow = 4;
		}
		
		//XSSFCellStyle styleVal = sheet.getRow(2).getCell(1).getCellStyle();
		for(int i=0;i<header.getRows().size();i++){
			XSSFRow row=sheet.getRow(startRow);
			if(row == null){
				row=sheet.createRow(startRow);
			}
//			XSSFCellStyle style =  (XSSFCellStyle)styleGreen.clone();
			//sheet.addMergedRegion(new CellRangeAddress(startRow, startRow, 0, 2));
			sheet.addMergedRegion(new CellRangeAddress(startRow, startRow, 1, 9));
			DtoRow rowHeader = header.getRows().get(i);
			
			fillCell(row, 0, rowHeader.getTitle(), XSSFCell.CELL_TYPE_STRING, true,styleGreen);
			fillCell(row, 1, rowHeader.getValue(), XSSFCell.CELL_TYPE_STRING, true,null);
			startRow++;
		}		
		sheet.addMergedRegion(new CellRangeAddress(startRow, startRow, 0, 9));
		return startRow;
	}
	
	
	protected XSSFCellStyle createFillBackGroundColor(XSSFWorkbook workBook, XSSFColor color, XSSFCellStyle oldStyle) {
		XSSFCellStyle style = null;
		if (oldStyle != null) {
		style = (XSSFCellStyle)oldStyle.clone();
		
		}
		else {
		style = workBook.createCellStyle();
		
		}

		style.setFillPattern(XSSFCellStyle.FINE_DOTS);
		style.setFillForegroundColor(color);
		style.setFillBackgroundColor(color);
		return style;
		}

	public XSSFWorkbook getWorkBook(){
		try {
			
			return new XSSFWorkbook(ExportExcel.class.getResourceAsStream(template_name));
		} catch (IOException e) {
			
			System.out.println(e.getMessage());
		}
		return null;
	}
	public XSSFSheet getSheet(XSSFWorkbook workBook){
		return workBook.getSheetAt(SHEET_EXPORT);
	}
	
	
	protected  XSSFCell fillCell(XSSFRow r, int cellnr, String content,int type,boolean isLock,XSSFCellStyle style) {
		
		XSSFCell cell = r.getCell((short)cellnr);
		if (cell==null) {
			cell = r.createCell((short)cellnr);
			
			
		}
		//type = cell.getCellType();		
		//cell.setCellType(type);
		if(style == null){
			style = cell.getCellStyle();
			setCellBorder(style);
		}
		
		
		style.setWrapText(true);
		style.setLocked(isLock);
		
		
		if(type==XSSFCell.CELL_TYPE_BOOLEAN){
			if(StringUtils.isNotBlank(content)){
				cell.setCellValue(Boolean.valueOf(content));
			}else{
				//if  value null
				cell.setCellValue(new XSSFRichTextString());
			}
		}else if(type==XSSFCell.CELL_TYPE_NUMERIC){
			if(StringUtils.isNotBlank(content)){
				cell.setCellValue(Double.valueOf(content));	
			}else{
				//if value null
				cell.setCellValue(new XSSFRichTextString());
			}
		}else if(type==XSSFCell.CELL_TYPE_STRING){
			cell.setCellValue(content);
		}	
		cell.setCellStyle(style);
		return cell;
	}
	protected Object loadData(Class<?> responseCls, String fileName) throws Exception {

		
		JAXBContext jc = JAXBContext.newInstance(responseCls);
		Unmarshaller marshal = jc.createUnmarshaller();
		FileInputStream is = new FileInputStream(fileName);
		try{
		return marshal.unmarshal(is);
		}finally{
			is.close();
		}
		
		}
}
