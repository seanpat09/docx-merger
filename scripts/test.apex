Id contentDocumentId = '<REPLACE_WITH_DOC_ID>';
Id parentId = '<REPLACE_WITH_PARENT_ID>';
Map<String,String> mergeFields = new Map<String,String>{
        '{{ mergefield }}' =>  'I HAVE BEEN MERGED',
        '{{ header1 }}' =>  'NEW HEADER 1',
        '{{ header2 }}' =>  'NEW HEADER 2'
    };
new DocxMerger()
    .mergeDoc(contentDocumentId, parentId, mergeFields);