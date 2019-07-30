c.content.pdfjs = False
c.session.lazy_restore = True

c.url.default_page = 'about:blank'
c.url.searchengines = {'DEFAULT': 'https://google.com/search?q={}'}

config.bind('d', 'scroll-page 0 0.5')
config.bind('u', 'scroll-page 0 -0.5')
config.bind('D', 'tab-close')
config.bind('E', 'tab-close -o')

config.bind('<Ctrl+b>', 'quickmark-save')
