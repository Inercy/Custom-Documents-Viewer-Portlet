package com.inercy.liferay.portlets.documents.entity;

public class File {

	public long folderId;
	public String name;
	public String extension;
	public long size;
	public String url;
	private Folder folder;
	
	public File(Folder folder, long folderId, String name, String extension, long size) {
		super();
		this.folderId = folderId;
		this.name = name;
		this.extension = extension;
		this.size = size;
		this.folder = folder;
		this.url = createURL();
	}
	
	public File(long folderId, String name, String extension, long size) {
		super();
		this.folderId = folderId;
		this.name = name;
		this.extension = extension;
		this.size = size;
	}

	public long getFolderId() {
		return folderId;
	}

	public void setFolderId(long folderId) {
		this.folderId = folderId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getExtension() {
		return extension;
	}

	public void setExtension(String extension) {
		this.extension = extension;
	}

	public long getSize() {
		return size;
	}

	public void setSize(long size) {
		this.size = size;
	}
	
	private String createURL(){
		return "/documents/" + folder.getRepositoryId() + "/" + folderId + "/" + name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	

}
