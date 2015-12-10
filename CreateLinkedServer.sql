-- ========================================
-- Add Linked Server Access MDB template
-- ========================================
exec sp_dropserver 'FZ', 'droplogins'

EXEC sp_addlinkedserver 
	@server = 'FZ', 
	@provider = 'Microsoft.ACE.OLEDB.12.0', 
	@srvproduct = 'OLE DB Provider for Ace',
	@datasrc = 'C:\Users\monst_000\YandexDisk\FightZona\FightZona.accdb'
GO

exec sp_addlinkedsrvlogin 'FZ', FALSE, null, Admin, Null