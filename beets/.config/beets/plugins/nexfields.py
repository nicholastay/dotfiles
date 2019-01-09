# Basic plugin to add the field(s) I need
# I usually want folders to sort by language, or whatever classification
# eg /K/ = korean, /JP/ = japanese, etc.
from beets.plugins import BeetsPlugin
from beets import mediafile

# Here we just need 1 field, we call it NEX_STORAGE
class NexFieldsPlugin(BeetsPlugin):
    def __init__(self):
        super(NexFieldsPlugin, self).__init__()
        field = mediafile.MediaField(
            mediafile.MP3DescStorageStyle(u'NEX_STORAGE'),
            mediafile.StorageStyle(u'NEX_STORAGE'),
            mediafile.ASFStorageStyle(u'NEX_STORAGE'),
            mediafile.MP4StorageStyle('----:com.apple.iTunes:NEX_STORAGE')
        )
        self.add_media_field('nex_storage', field)
        self.template_funcs['rmFirst'] = _tmpl_rmFirst


# Helper function to remove the first x characters
def _tmpl_rmFirst(text, tn):
    if text:
        n = int(tn)
        if n > 0:
            return text[n:]
        else:
            return text
    else:
        return u''