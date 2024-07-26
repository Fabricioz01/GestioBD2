from reportlab.lib.pagesizes import letter, landscape
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle

def generar_pdf(logs, auditoria, usuario, fecha_inicio, fecha_fin):
    # Crear directorio 'reportes' si no existe
    import os
    if not os.path.exists('reportes'):
        os.makedirs('reportes')

    # Nombre del archivo PDF
    pdf_filename = f'reportes/reporte_logs_{usuario}_{fecha_inicio.replace(":", "-").replace(" ", "_")}_a_{fecha_fin.replace(":", "-").replace(" ", "_")}.pdf'
    doc = SimpleDocTemplate(pdf_filename, pagesize=landscape(letter))
    styles = getSampleStyleSheet()
    custom_style = ParagraphStyle(
        name='CustomStyle',
        fontSize=9,
        leading=10,
        spaceAfter=4,
        wordWrap='CJK'
    )
    date_time_style = ParagraphStyle(
        name='DateTimeStyle',
        fontSize=9,
        leading=10,
        spaceAfter=4,
        wordWrap='CJK',
        alignment=1
    )
    elements = []

    # Título del reporte
    title = f"Reporte: Logs de SQL Server\nUsuario: {usuario}\nDesde: {fecha_inicio}\nHasta: {fecha_fin}"
    elements.append(Paragraph(title, styles['Title']))
    elements.append(Spacer(1, 12))

    # Añadir la tabla de logs
    if logs:
        elements.append(Paragraph("Logs de SQL Server", styles['Heading2']))
        col_widths = [100, 500]
        data = [["Fecha y Hora", "Log Entry"]]
        
        for log in logs:
            data.append([
                Paragraph(log['fecha_hora'], date_time_style),
                Paragraph(log['linea'], custom_style)
            ])

        table = Table(data, colWidths=col_widths)
        table.setStyle(TableStyle([
            ('BACKGROUND', (0, 0), (-1, 0), colors.purple),
            ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
            ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
            ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
            ('FONTSIZE', (0, 0), (-1, 0), 10),
            ('BOTTOMPADDING', (0, 0), (-1, 0), 10),
            ('BACKGROUND', (0, 1), (-1, -1), colors.skyblue),
            ('GRID', (0, 0), (-1, -1), 0.5, colors.cyan),
            ('FONTSIZE', (0, 1), (-1, -1), 9),
        ]))
        elements.append(table)
        elements.append(Spacer(1, 12))

    # Añadir la tabla de auditoría
    if auditoria:
        elements.append(Paragraph("Tabla de Auditoría", styles['Heading2']))
        col_widths = [100, 100, 100, 400]
        data = [["Fecha y Hora", "Tabla", "Acción", "Descripción de Cambios"]]
        
        for entry in auditoria:
            data.append([
                Paragraph(entry['fecha_hora'], date_time_style),
                Paragraph(entry['nombre_tabla'], custom_style),
                Paragraph(entry['accion'], custom_style),
                Paragraph(entry['descripcion_cambios'], custom_style)
            ])

        table = Table(data, colWidths=col_widths)
        table.setStyle(TableStyle([
            ('BACKGROUND', (0, 0), (-1, 0), colors.black),
            ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
            ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
            ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
            ('FONTSIZE', (0, 0), (-1, 0), 10),
            ('BOTTOMPADDING', (0, 0), (-1, 0), 10),
            ('BACKGROUND', (0, 1), (-1, -1), colors.salmon),
            ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
            ('FONTSIZE', (0, 1), (-1, -1), 9),
        ]))
        elements.append(table)

    doc.build(elements)
    print(f"PDF generado exitosamente en '{pdf_filename}'")
