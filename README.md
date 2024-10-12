# Zotero

Zotero is a free & open source reference manager. With just a few tweaks, it is the perfect tool to help you organize all your messy pdfs.

## Installing

First [download](https://www.zotero.org/download/) __Zotero for desktop__, and the browser addon __Zotero Connector__. If you are on Linux, it is best to download the Flatpak desktop install from [Flathub](https://flathub.org/apps/org.zotero.Zotero). 

The browser addon [Zotero Connector](https://www.zotero.org/download/) will automatically save the references from your browser with the click of a button: for example, if you are on the official webpage of a paper, it will automatically save all the related information, authors, DOI, etc.

You definitely should also install the plugins [Better BibTex for Zotero](https://retorque.re/zotero-better-bibtex/installation/index.html), which lets you customize the citation keys; and [ZotFile](http://zotfile.com/#how-to-install--set-up-zotfile) (discontinued, for versions < Zotero 7), or [ZotMoov](https://github.com/wileyyugioh/zotmoov) (all versions, including >= Zotero 7), which automatically rename the PDFs and saves them on a custom folder, which you can sync with the cloud or else.

Another cool and useful plugin is the [Inciteful Zotero Plugin](https://github.com/inciteful-xyz/inciteful-zotero-plugin), which helps you find related literature.

Finally, there is a native dark mode for the Linux Flatpak installation. But if you are on Windows and want a dark mode for Zotero, take a look at [Zotero Shadow](https://github.com/pablogila/ZoteroShadow).

Some of these addons require a small configuration to work flawlessly, which is indicated below.

## Automatic and custom citation keys

You can edit the automatic citation keys by going to `Tools, Better BibTex, Open Better BibTex preferences, Citation keys`. There you can modify the citation key formula, for example as `auth.lower + year` to have automatic citation keys such as _druzbicki2023_.

You can also create a custom citation key for any particular reference, by editing the `Extra` section of said reference with `citation key: MyCustomKey`.

## Saving files to a custom folder

To automatically move your pdfs with ZotFile to a custom folder (to sync it, etc), go to `Tools, ZotFile Preferences, General Settings, Location of Files, Custom Location` and select your desired folder. This same folder should also be specified for Zotero itself, at `Edit, Preferences, Advanced, Files and Folders, Linked Attachment Base Directory`.
In case you are using ZotMoov instead of ZotFile, the folder path is located on ZotMoov settings.

## Renaming rules

As of Zotero 7 the [renaming rules](https://www.zotero.org/support/file_renaming) have been modified.
The new renaming rule is quite easy, e.g.
`{{ citationKey }} - {{ title }}`

For ZotFile there was a problem with subinexes, so check the next section.
ZotMoov has fixed the subindex bug, so the following only applies for ZotFile.

## Renaming titles with subindexes via ZotFile

Some papers have subindexes on the title, such as in MAPbI<sub>3</sub>. These subindexes are rendered in HTML, using the tags `MAPbI<sub>3</sub>`. This is useful when referencing, but instead of saving titles as `MAPbI3`, ZotFile will incorrectly introduce those "sub" tags on the renamed PDFs by default. To remove HTML tags such as `<sub>` from the renamed pdf files, you need to configure a custom ZotFile User Wildcard. [(source)](https://github.com/jlegewie/zotfile/issues/455)
To fix that, simply go to `Edit, Preferences, Advanced, Config Editor` and click on accept the risk (because if we are brave enough there is no risk). Search for `zotfile.wildcards.user`, and introduce the following text:
```
{"1": {"field": "title", "operations":[{"function": "replace", "regex": "<sub>", "replacement":"", "flags":"g"},{"function": "replace", "regex": "</sub>", "replacement":"", "flags":"g"}]}}
```
You have now configured a custom User Wildcard. You can now extract the title without the HTML tags by writting `{%1}` on the ZotFile renaming rules, located in `Tools, ZotFile Preferences, Renaming Rules`.
For example, to rename all PDFs as `CitationKey - Title`, you should configure ZotFile renaming rules as `{%b - }{%1}`.

## Supporting Information PDFs

It is recommended to save the Supporting Information (SI) of the papers by creating a copy of the corresponding reference (with a right click), adding "Supplementary" at the end of the title, then attaching the supplementary pdf, and finally editing the citation key as `CitationKey_SI`. This prevents SI to be renamed incorrectly, since __ZotFile and ZotMoov only seems to work fine with one attachment per reference__.

