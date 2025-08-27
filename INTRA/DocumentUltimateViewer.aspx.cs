using System;
using System.Linq;

namespace INTRA4U
{
    public partial class DocumentUltimateViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // The document handler type which provides a custom way of loading the input files.
            // This class should implement IDocumentHandler interface and should have a parameterless
            // constructor so that it can be instantiated internally when necessary.
            // Value of Document property will be passed to this handler which should open 
            // and return a readable stream according to that file identifier.
            // See below for CustomDocumentHandler class which implements IDocumentHandler interface

            //documentViewer.DocumentHandlerType = typeof(CustomDocumentHandler);

            // If a custom document handler is provided via DocumentHandlerType property, then
            // this value will be passed to that handler which should open and return a readable stream according 
            // to this file identifier. 
            // So it can be any string value that your IDocumentHandler implementation understands.
            //documentViewer.Document = "~/DocUltimateViewer/To use DocumentUltimate in an ASP.NET WebForms Project, do the following in Visual Studio.pdf";

            //---------------------------------------------
            // Here is an example (commented out) for loading a document from database.
            // See below for DbDocumentHandler class which implements IDocumentHandler interface.
            // This loads the document with passed ID (176) from the database
            /*
            documentViewer.DocumentHandlerType = typeof(DbDocumentHandler);
            documentViewer.Document = "176"; // a file path or identifier
            
            // When you need to pass custom parameters along with the input file to your handler implementation,
            // use documentViewer.DocumentHandlerParameters property to set your parameters.
            // These will be passed to the methods of your handler implementation:
            documentViewer.DocumentHandlerParameters.Set("connectionString", "SOME CONNECTION STRING");
            */
            //---------------------------------------------


            //---------------------------------------------
            //When you don't have a file on disk and implementing IDocumentHandler interface is not convenient, 
            //you can use documentViewer.DocumentSource property to load documents from a stream or a byte array. 
            //Note that your stream or byte array will be copied to the cache folder if not already exists 
            //when you load via DocumentSource because DocumentViewer needs to access your document 
            //out of the context of the host page (i.e. serialization is needed). 

            //Load document from a stream:
            /*
            documentViewer.DocumentSource = new DocumentSource(
                new DocumentInfo(uniqueId, fileName),
                new StreamResult(stream)
            );
            */

            //Load document from a byte array:
            /*
            documentViewer.DocumentSource = new DocumentSource(
                new DocumentInfo(uniqueId, fileName),
                byteArray
            );
            */
            //---------------------------------------------
        }
    }

}