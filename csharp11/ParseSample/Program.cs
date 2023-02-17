using ParseSample;

ReadOnlySpan<char> name = "Christian Ernst Nagel".AsSpan();
if (Person.TryParse(name, null, out Person? p))
{
    Console.WriteLine(p.FirstName);
    Console.WriteLine(p.MiddleName);
    Console.WriteLine(p.LastName);
}

QueryParam<int> qp1 = new("42", 0);
Console.WriteLine(qp1.Value);
QueryParam<Person> qp2 = new("Tom Turbo", Person.Empty);
Person p2 = qp2.Value;
Console.WriteLine(p2);

var dataSpan = new char[64].AsSpan();
if (p2.TryFormat(dataSpan, out int chars, "F".AsSpan()))
{
    var first = dataSpan[..chars];
    Console.WriteLine(first.ToString());
}
