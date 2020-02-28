object myPlanDataModule: TmyPlanDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 309
  Width = 308
  object BaseConnection: TFDConnection
    Params.Strings = (
      'Database=D:\Delphi10\Space\myplan\aacenSqlLite.sdb'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 56
    Top = 24
  end
  object myPlanQuery1: TFDQuery
    Connection = BaseConnection
    SQL.Strings = (
      'drop table Plan;'
      'create table if not exists test('
      '  id int primary key not null,'
      '  name text not null,'
      '  age int not null'
      ');'
      'create table if not exists Plan('
      '  id integer primary key AUTOINCREMENT,'
      '  name text not null,'
      '  classify int not null,'
      '  money real not null,'
      '  bz text not null,'
      '  del int not null,'
      '  create_time text not null,'
      '  plan_time  text not null'
      ');')
    Left = 24
    Top = 128
  end
  object tableInit: TFDQuery
    Connection = BaseConnection
    SQL.Strings = (
      'CREATE TABLE if not exists Plan ('
      '    id          INTEGER  PRIMARY KEY AUTOINCREMENT,'
      '    name        TEXT     NOT NULL,'
      '    classify    INT      NOT NULL,'
      '    money       REAL     NOT NULL,'
      '    bz          TEXT     NOT NULL,'
      '    del         INT      NOT NULL,'
      '    create_time DATETIME,'
      '    plan_time   DATETIME,'
      '    msid INTEGER Default 0'
      ');'
      'CREATE TABLE if not exists MonthsSetting ('
      '    id          INTEGER  PRIMARY KEY AUTOINCREMENT,'
      '    year        TEXT     NOT NULL,'
      '    month       INT      NOT NULL,'
      '    budget      DOUBLE   NOT NULL,'
      '    income      DOUBLE   NOT NULL,'
      '    expend      DOUBLE   NOT NULL,'
      '    bz          TEXT     NOT NULL,'
      '    del         INT      NOT NULL,'
      '    status      INT      NOT NULL,'
      '    create_time DATETIME,'
      '    plan_time   TEXT'
      ');'
      'CREATE TABLE if not exists Users ('
      '    id          INTEGER PRIMARY KEY AUTOINCREMENT,'
      '    name        TEXT    NOT NULL,'
      '    password    TEXT    NOT NULL,'
      '    wxid        TEXT    NOT NULL,'
      '    zfbid       TEXT    NOT NULL,'
      '    del         INT     NOT NULL,'
      '    create_time TEXT    NOT NULL,'
      '    plan_time   TEXT    NOT NULL'
      ');')
    Left = 200
    Top = 112
  end
end
