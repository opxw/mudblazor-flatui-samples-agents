// Copyright (c) 2026 opx. All rights reserved.
using System.Text;
namespace Opx.MudBlazor.FlatUi.Showcase;
public static class SamplePdfDocument
{
public static byte[] Create()
{
    const int pageCount = 12;
    var objects = new List<string>();
    var pageObjectNumbers = Enumerable.Range(0, pageCount).Select(index => 3 + (index * 2)).ToArray();
    var fontObjectNumber = 3 + (pageCount * 2);
    objects.Add("<< /Type /Catalog /Pages 2 0 R >>");
    objects.Add($"<< /Type /Pages /Kids [{string.Join(' ', pageObjectNumbers.Select(number => $"{number} 0 R"))}] /Count {pageCount} >>");

    for (var index = 0; index < pageCount; index++)
    {
        var pageNumber = index + 1;
        var contentObjectNumber = pageObjectNumbers[index] + 1;
        var content = $"BT /F1 20 Tf 72 760 Td (Sales Report - August 2026) Tj 0 -34 Td /F1 12 Tf (Page {pageNumber} of {pageCount}) Tj 0 -42 Td (OPX PDF.js responsive viewer sample) Tj 0 -28 Td (Parameters, search, thumbnails, download, share, and print are host-controlled.) Tj ET";
        objects.Add($"<< /Type /Page /Parent 2 0 R /MediaBox [0 0 595 842] /Resources << /Font << /F1 {fontObjectNumber} 0 R >> >> /Contents {contentObjectNumber} 0 R >>");
        objects.Add($"<< /Length {Encoding.ASCII.GetByteCount(content)} >>\nstream\n{content}\nendstream");
    }

    objects.Add("<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>");
    using var stream = new MemoryStream();
    using var writer = new StreamWriter(stream, Encoding.ASCII, leaveOpen: true) { NewLine = "\n" };
    writer.WriteLine("%PDF-1.4");
    writer.Flush();
    var offsets = new List<long> { 0 };
    for (var index = 0; index < objects.Count; index++)
    {
        offsets.Add(stream.Position);
        writer.WriteLine($"{index + 1} 0 obj");
        writer.WriteLine(objects[index]);
        writer.WriteLine("endobj");
        writer.Flush();
    }

    var xrefOffset = stream.Position;
    writer.WriteLine("xref");
    writer.WriteLine($"0 {objects.Count + 1}");
    writer.WriteLine("0000000000 65535 f ");
    foreach (var offset in offsets.Skip(1)) writer.WriteLine($"{offset:0000000000} 00000 n ");
    writer.WriteLine("trailer");
    writer.WriteLine($"<< /Size {objects.Count + 1} /Root 1 0 R >>");
    writer.WriteLine("startxref");
    writer.WriteLine(xrefOffset);
    writer.WriteLine("%%EOF");
    writer.Flush();
    return stream.ToArray();
}
}
