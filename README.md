# Solutions to view PDF in a Flutter app

### 2 main solutions

→ Using in-app PDF views
→ Using web views (in-app or external app)

| PDF Viewers    | flutter_pdfview | pdfx (PDFView)   | pdfx (PDFViewPinch) 
|----------------|-----------------|---------------|----------------|
| Zoom           | 4/5             | 3/5           | 5/5 (blurry while rendering)
| Page snapping  | ✅              | ✅            | ❌ 





| PDF Viewers    | PDF Viewers |Web views    
|----------------|-----------------|---------------
| Pros           | <ul><li>UX/UI freedom</li><li>PDF Viewer customization</li></ul>      | <ul><li>No need for flutter package</li><li>User could be used to using webviews</li></ul>
| Cons  | <ul><li>Precise zoom is limited or possible but blurry while rendering</li><li>PDF Viewer customization</li></ul>              | ✅           


---

url_launcher:

- sur android uniquement, ne permet pas d'afficher un PDF en inAppView
  https://github.com/flutter/flutter/issues/105205
  https://github.com/facebook/react-native/issues/6488
- sur android uniquement en lançant en externalApp, le PDF se télécharge automatiquement (pas possibilité de le voir dans le browser sans le dl ?)
- en cas d'issue SSL
  - LaunchMode.inAppWebView
    - sur iOS la webview affiche la page de warning du au SSL
    - sur android la webview affiche un blank screen
  - LaunchMode.externalApplication
    - sur iOS la webview affiche la page de warning du au SSL
    - sur android la webview affiche la page de warning du au SSL

webview_flutter:

- en faisant un nouveau  _webViewController.loadRequest(Uri.parse(widget.url)), le widget ne prend pas en compte ce changement alors qu'un rebuild a bien été demandé --> usage de UniqueKey() pour forcer la reconstruction du widget
- sur android le PDF ne s'affiche pas dans la webview
- en cas d'issue SSL
  - sur iOS la webview affiche la dernière URL
  - sur android la webview affiche un blank screen


flutter_inappwebview

- en faisant un nouveau build avec une nouvel URL dans initialUrlRequest: URLRequest(url: Uri.parse(url)), la webview ne change pas l'url --> usage de UniqueKey() pour forcer la reconstruction du widget
- sur android le PDF ne s'affiche pas dans la webview
- en cas d'issue SSL
  - sur iOS la webview affiche un blank screen
  - sur android la webview affiche un blank screen


Remarque générales

- les webviews android ne semblent pas supporter l'affichage de PDF (d'où les pages blanches)
- une astuce est d'utiliser google drive (en ligne) qui lui sait lire les pdf