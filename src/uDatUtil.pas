unit uDatUtil;

interface

function DatetoAAAAMMJJ(ADate: TDate): string;

function AAAAMMJJToDate(AAAAMMJJ:String): TDate;

implementation

uses
  System.SysUtils;

  function DatetoAAAAMMJJ(Adate: TDate): string;
  begin
    result:=FormatDateTime('yyyymmdd',Adate);
  end;

  function AAAAMMJJToDate(AAAAMMJJ:string): TDate;
  begin
    result:=EncodeDate(AAAAMMJJ.Substring(0,4).ToInteger,AAAAMMJJ.Substring(4,2).ToInteger,AAAAMMJJ.Substring(6,2).ToInteger);
  end;

end.
