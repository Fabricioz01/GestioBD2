from reportlab.lib.pagesizes import letter, landscape
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle

def generar_pdf(logs, usuario, fecha_inicio, fecha_fin):
    pdf_filename = f'reporte_logs_{usuario}_{fecha_inicio.replace(":", "-").replace(" ", "_")}_a_{fecha_fin.replace(":", "-").replace(" ", "_")}.pdf'
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

    title = f"""
    <b>Reporte: Logs de MySQL</b><br/>
    <b>Usuario:</b> {usuario}<br/>
    <b>Desde:</b> {fecha_inicio}<br/>
    <b>Hasta:</b> {fecha_fin}
    """
    elements.append(Paragraph(title, styles['Title']))
    elements.append(Spacer(1, 12))

    col_widths = [100, 500]
    data = [["Fecha y Hora", "Log Entry"]]
    
    for log in logs:
        data.append([
            Paragraph(log['fecha_hora'], date_time_style),
            Paragraph(log['linea'], custom_style)
        ])

    table = Table(data, colWidths=col_widths)
    table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.lightcoral),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 10),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 10),
        ('BACKGROUND', (0, 1), (-1, -1), colors.peachpuff),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.mistyrose),
        ('FONTSIZE', (0, 1), (-1, -1), 9),
    ]))

    elements.append(table)
    doc.build(elements)
    print(f"PDF generado exitosamente en '{pdf_filename}'")

# Ejemplo de uso:
logs = [
    {'fecha_hora': '2024-07-25 10:00:00', 'linea': 'Log de ejemplo 1'},
    {'fecha_hora': '2024-07-25 10:05:00', 'linea': 'Log de ejemplo 2'}
]
usuario = 'usuario123'
fecha_inicio = '2024-07-25 00:00:00'
fecha_fin = '2024-07-25 23:59:59'

generar_pdf(logs, usuario, fecha_inicio, fecha_fin)
