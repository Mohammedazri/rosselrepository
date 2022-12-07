public class testPDFController {
    public Boolean renderIframe {get;set;}
    public Id RecordId {get;set;}
    private final String versionData;

    public testPDFController() {
        RecordId  = ApexPages.currentPage().getParameters().get('id');
        renderIframe = false;
        
        List<EmailMessage> emailsList = Database.query(
            'SELECT Id ' +
            'FROM EmailMessage ' + 
            'Where ParentId = :RecordId '+
            'ORDER BY CreatedDate DESC '
        );
        
        if (emailsList.size() > 0) {
            String emailId = emailsList[0].Id;
            String pdfStr = '\'PDF\'';
            List<ContentDocumentLink> cdlist = Database.query(
                'SELECT Id, ContentDocument.LatestPublishedVersionId ' +
                'FROM ContentDocumentLink ' + 
                'WHERE LinkedEntityId = :emailId '+
                'AND ContentDocument.LatestPublishedVersionId != null '+
                'AND ContentDocument.LatestPublishedVersion.FileType = :pdfStr '+
                'ORDER BY SystemModstamp DESC '
            );
            if (cdlist.size() > 0) {
                String cvId = cdlist[0].ContentDocument.LatestPublishedVersionId;
                List<ContentVersion> cvlist = Database.query(
                    'SELECT Id, FileType, VersionData ' +
                    'FROM ContentVersion' + 
                    'WHERE Id = :cvId '+
                    'ORDER BY CreatedDate DESC '
                );
                versionData = EncodingUtil.base64Encode(cvlist[0].VersionData);
                renderIframe = true;
            }
        }
    
    }

    public String getVersionData() {
        return versionData;
    }
}