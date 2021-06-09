public with sharing class DocxMerger {
    public void mergeDoc(Id contentDocId, Id parentId, Map<String,String> mergeFields) {
        ContentVersion cv = [
            SELECT VersionData
            FROM ContentVersion
            WHERE ContentDocumentId = :contentDocId 
            AND IsLatest = true
        ];

        Zippex sampleZip = new Zippex(cv.VersionData);
        Blob fileData = sampleZip.getFile('word/document.xml');
        String docxml = fileData.toString();

        for(String mergeField : mergeFields.keySet()) {
            docxml = docxml.replace(mergeField, mergeFields.get(mergeField));
        }

        Blob mergedData = Blob.valueof(docxml);
        sampleZip.addFile('word/document.xml', mergedData, null);

        String newTitle = 'merged' + Datetime.now().getTime();
        ContentVersion mergedFile = new ContentVersion();
        mergedFile.VersionData = sampleZip.getZipArchive();
        mergedFile.Title = newTitle;
        mergedFile.ContentLocation= 's';
        mergedFile.PathOnClient= newTitle+'.docx';
        insert mergedFile;

        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:mergedFile.Id].ContentDocumentId;
        ContentDocumentLink cDe = new ContentDocumentLink();
        cDe.ContentDocumentId = conDoc;
        cDe.LinkedEntityId = parentId;
        cDe.ShareType = 'I';
        cDe.Visibility = 'AllUsers';
        insert cDe;
    }
}
