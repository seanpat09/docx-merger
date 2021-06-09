# Docx Merger

This is a tool to replace merge fields on a `.docx` file. By using [Zippex](https://github.com/pdalcol/Zippex) to unzip a `docx` file, we can replace merge fields in a `docx` and save it as a new File.

## Usage

```
//This File must be a docx file
Id contentDocumentId = '<REPLACE_WITH_DOC_ID>';
Id parentId = '<REPLACE_WITH_PARENT_ID>';
Map<String,String> mergeFields = new Map<String,String>{
        '{{ mergefield }}' =>  'I HAVE BEEN MERGED',
        '{{ header1 }}' =>  'NEW HEADER 1',
        '{{ header2 }}' =>  'NEW HEADER 2'
    };
new DocxMerger()
    .mergeDoc(contentDocumentId, parentId, mergeFields);
```

After running this, the parent record will have a new file with merged fields.
