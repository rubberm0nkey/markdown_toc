program markdown_toc;

uses
  classes, sysutils;

function level(const str:string):integer;
var
  i: integer;
  h: string;
begin
  result:=0;
  h:='#';
  for i:=1 to 9 do begin
    if str.StartsWith(h) then inc(result);
    h:=h+'#';
  end;
end;

function space(const count:integer):string;
var
  i:integer;
begin
  result:='';
  for i:=0 to count-1 do result:=result+' ';
end;

function tocitem(const line:string; level:integer):string;
var
  txt, link:string;
begin
  txt:=trim(line.Substring(level+1));
  link:=txt;
  link:=link.Replace('!','',[rfReplaceAll]);
  link:=link.Replace('"','',[rfReplaceAll]);
  link:=link.Replace('#','',[rfReplaceAll]);
  link:=link.Replace('%','',[rfReplaceAll]);
  link:=link.Replace('&','',[rfReplaceAll]);
  link:=link.Replace('''','',[rfReplaceAll]);
  link:=link.Replace('(','',[rfReplaceAll]);
  link:=link.Replace(')','',[rfReplaceAll]);
  link:=link.Replace('*','',[rfReplaceAll]);
  link:=link.Replace(',','',[rfReplaceAll]);
  link:=link.Replace('.','',[rfReplaceAll]);
  link:=link.Replace('/','',[rfReplaceAll]);
  link:=link.Replace(';','',[rfReplaceAll]);
  link:=link.Replace('<','',[rfReplaceAll]);
  link:=link.Replace('>','',[rfReplaceAll]);
  link:=link.Replace('?','',[rfReplaceAll]);
  link:=link.Replace('@','',[rfReplaceAll]);
  link:=link.Replace('[','',[rfReplaceAll]);
  link:=link.Replace(']','',[rfReplaceAll]);
  link:=link.Replace('{','',[rfReplaceAll]);
  link:=link.Replace('|','',[rfReplaceAll]);
  link:=link.Replace('}','',[rfReplaceAll]);
  link:=link.Replace('Á','á',[rfReplaceAll]);
  link:=link.Replace('É','é',[rfReplaceAll]);
  link:=link.Replace('Í','í',[rfReplaceAll]);
  link:=link.Replace('Ó','ó',[rfReplaceAll]);
  link:=link.Replace('Ö','ö',[rfReplaceAll]);
  link:=link.Replace('Ú','ú',[rfReplaceAll]);
  link:=link.Replace('Ü','ü',[rfReplaceAll]);
  link:=link.Replace('Ű','ű',[rfReplaceAll]);
  link:=link.Replace(' ','-',[rfReplaceAll]);
  link:=trim(lowercase(link));
  result:=format(space(2*(level-1)) + '- [%s](#%s)', [txt,link]);
end;

function createtoc(const fn:string; const startline:integer):tstringlist;
var
  i, lvl: integer;
  md: tstringlist;
  item: string;
  code: boolean;
begin

  md:=tstringlist.Create;
  md.LoadFromFile(fn);

  result:=tstringlist.Create;

  code:=false;

  for i:=startline to md.Count-1 do begin

    if md[i].StartsWith('```') then code:=not code;

    if not code then begin

      lvl:= level(md[i]);

      if lvl > 0 then begin
        item:=tocitem(md[i], lvl);
        result.Add(item);
      end;

    end;

  end;

  md.Free;

end;

procedure findtocpos(const fn:string; var tocbeginpos, tocendpos: integer);
var
  i: integer;
  md: tstringlist;
begin
  md:=tstringlist.Create;
  md.LoadFromFile(fn);

  tocbeginpos:=-1;
  tocendpos:=-1;

  for i:=0 to md.Count - 1 do begin

    if lowercase(md[i]).StartsWith('<!--toc.begin-->') then tocbeginpos:=i;
    if lowercase(md[i]).EndsWith('<!--toc.end-->') then tocendpos:=i;

  end;

  md.Free;

end;

procedure updatetoc(const fn:string);
var
  i: integer;
  tocbegin, tocend: integer;
  md, newmd, toc: tstringlist;
begin

  tocbegin:=-1;
  tocend:=-1;

  findtocpos(fn, tocbegin, tocend);

  writeln('TOC.Begin: ', tocbegin, ' TOC.End: ', tocend);

  if (tocbegin<0) or (tocend<tocbegin) then begin
    writeln('Error: Bad TOC.Begin and/or TOC.End signal.');
    exit;
  end;

  toc:=createtoc(fn, tocend);

  md:=tstringlist.Create;
  md.LoadFromFile(fn);

  newmd:=tstringlist.Create;

  for i:=0 to tocbegin do newmd.Add(md[i]);
  newmd.AddStrings(toc);
  for i:=tocend to md.Count-1 do newmd.Add(md[i]);

  md.Free;

  newmd.SaveToFile(fn);

  newmd.Free;

  writeln('TOC updated');

end;


begin

  if fileexists( paramstr(1) ) then begin
    updatetoc( paramstr(1) );
  end else begin
    writeln('Usage:');
    writeln('');
    writeln('markdown_toc path/to/markdown/file.md');
    writeln('');
  end;

end.

