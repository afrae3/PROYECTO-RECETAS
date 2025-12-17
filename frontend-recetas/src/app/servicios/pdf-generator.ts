import { Injectable } from '@angular/core';
import jsPDF from 'jspdf';
import autoTable from 'jspdf-autotable';

export interface IngredienteAgrupado {
  nombre: string;
  cantidadTotal: number;
  medida: string;
  recetas: string[]; 
}

@Injectable({
  providedIn: 'root'
})
export class PdfGenerator {

  /**
   * Genera un PDF con la lista de ingredientes agrupados
   * @param ingredientes Array de ingredientes agrupados
   * @param fechaInicio Fecha de inicio del menú
   * @param fechaFin Fecha de fin del menú
   */
  generarListaCompra(
    ingredientes: IngredienteAgrupado[], 
    fechaInicio: string, 
    fechaFin: string
  ): void {
    const doc = new jsPDF();
    
    const colorPrimario: [number, number, number] = [41, 128, 185]; 
    const colorSecundario: [number, number, number] = [52, 73, 94]; 
    
    doc.setFontSize(20);
    doc.setTextColor(colorPrimario[0], colorPrimario[1], colorPrimario[2]);
    doc.text('Lista de Compra Semanal', 105, 20, { align: 'center' });
    
    doc.setFontSize(12);
    doc.setTextColor(colorSecundario[0], colorSecundario[1], colorSecundario[2]);
    doc.text(`Del ${fechaInicio} al ${fechaFin}`, 105, 28, { align: 'center' });
    
    doc.setDrawColor(colorPrimario[0], colorPrimario[1], colorPrimario[2]);
    doc.setLineWidth(0.5);
    doc.line(20, 32, 190, 32);
    
    doc.setFontSize(10);
    doc.setTextColor(100);
    doc.text(`Generado el: ${new Date().toLocaleDateString('es-ES')}`, 20, 38);
    doc.text(`Total de ingredientes: ${ingredientes.length}`, 20, 43);
    
    const tableData = ingredientes.map((ing, index) => [
      index + 1,
      ing.nombre,
      `${ing.cantidadTotal.toFixed(2)} ${ing.medida}`,
      ing.recetas.join(', ')
    ]);
    
    autoTable(doc, {
      startY: 50,
      head: [['#', 'Ingrediente', 'Cantidad', 'Usado en']],
      body: tableData,
      theme: 'striped',
      headStyles: {
        fillColor: colorPrimario,
        textColor: [255, 255, 255],
        fontSize: 11,
        fontStyle: 'bold',
        halign: 'center'
      },
      bodyStyles: {
        fontSize: 10,
        textColor: colorSecundario
      },
      columnStyles: {
        0: { cellWidth: 15, halign: 'center' },
        1: { cellWidth: 60 },
        2: { cellWidth: 35, halign: 'center' },
        3: { cellWidth: 70, fontSize: 8 }
      },
      alternateRowStyles: {
        fillColor: [245, 245, 245]
      },
      margin: { top: 50, left: 20, right: 20 }
    });
    
    const pageCount = (doc as any).internal.getNumberOfPages();
    for (let i = 1; i <= pageCount; i++) {
      doc.setPage(i);
      doc.setFontSize(8);
      doc.setTextColor(150);
      doc.text(
        `Página ${i} de ${pageCount}`,
        105,
        doc.internal.pageSize.height - 10,
        { align: 'center' }
      );
    }
    
    doc.save(`lista-compra-${fechaInicio}-${fechaFin}.pdf`);
  }

 
  generarListaCheckbox(
    ingredientes: IngredienteAgrupado[],
    fechaInicio: string,
    fechaFin: string
  ): void {
    const doc = new jsPDF();
    const colorPrimario: [number, number, number] = [41, 128, 185];
    
    doc.setFontSize(18);
    doc.setTextColor(colorPrimario[0], colorPrimario[1], colorPrimario[2]);
    doc.text('Lista de Compra', 105, 20, { align: 'center' });
    
    doc.setFontSize(10);
    doc.setTextColor(100);
    doc.text(`Del ${fechaInicio} al ${fechaFin}`, 105, 27, { align: 'center' });
    
    let yPosition = 40;
    const lineHeight = 10;
    const checkboxSize = 5;
    
    ingredientes.forEach((ing, index) => {
      if (yPosition > 270) {
        doc.addPage();
        yPosition = 20;
      }
      
      doc.setDrawColor(100);
      doc.setLineWidth(0.3);
      doc.rect(20, yPosition - 4, checkboxSize, checkboxSize);
      
      doc.setFontSize(11);
      doc.setTextColor(50);
      doc.text(ing.nombre, 30, yPosition);
      
      doc.setFontSize(10);
      doc.setTextColor(100);
      doc.text(`${ing.cantidadTotal.toFixed(2)} ${ing.medida}`, 120, yPosition);
      
      yPosition += lineHeight;
    });
    
    doc.save(`checklist-compra-${fechaInicio}.pdf`);
  }


  generarListaPorCategorias(
    ingredientesPorCategoria: Map<string, IngredienteAgrupado[]>,
    fechaInicio: string,
    fechaFin: string
  ): void {
    const doc = new jsPDF();
    const colorPrimario: [number, number, number] = [41, 128, 185];
    const colorCategoria: [number, number, number] = [231, 76, 60];
    
    doc.setFontSize(18);
    doc.setTextColor(colorPrimario[0], colorPrimario[1], colorPrimario[2]);
    doc.text('Lista de Compra por Categorías', 105, 20, { align: 'center' });
    
    doc.setFontSize(10);
    doc.setTextColor(100);
    doc.text(`Del ${fechaInicio} al ${fechaFin}`, 105, 27, { align: 'center' });
    
    let yPosition = 40;
    
    ingredientesPorCategoria.forEach((ingredientes, categoria) => {
      if (yPosition > 250) {
        doc.addPage();
        yPosition = 20;
      }
      
      doc.setFontSize(14);
      doc.setTextColor(colorCategoria[0], colorCategoria[1], colorCategoria[2]);
      doc.text(categoria, 20, yPosition);
      yPosition += 8;
      
      ingredientes.forEach(ing => {
        if (yPosition > 270) {
          doc.addPage();
          yPosition = 20;
        }
        
        doc.setFontSize(10);
        doc.setTextColor(50);
        doc.text(`• ${ing.nombre}`, 25, yPosition);
        doc.setTextColor(100);
        doc.text(`${ing.cantidadTotal.toFixed(2)} ${ing.medida}`, 120, yPosition);
        
        yPosition += 6;
      });
      
      yPosition += 5; 
    });
    
    doc.save(`lista-por-categorias-${fechaInicio}.pdf`);
  }
}