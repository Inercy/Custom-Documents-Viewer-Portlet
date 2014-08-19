package com.inercy.liferay.portlets.documents.entity;

import java.util.List;

import org.apache.jasper.tagplugins.jstl.core.ForEach;

public class Folder {

	private long folderId;
	private String name;
	private long parentFolderId;
	private List<File> files;
	private List<Folder> subFolders;
	private long repositoryId;

	public Folder(long folderId, String name, long parentFolderId,
			List<Folder> subFolders, List<File> files, long repositoryId) {
		super();
		this.folderId = folderId;
		this.name = name;
		this.parentFolderId = parentFolderId;
		this.subFolders = subFolders;
		this.files = files;
	}

	public Folder() {
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

	public long getParentFolderId() {
		return parentFolderId;
	}

	public void setParentFolderId(long parentFolderId) {
		this.parentFolderId = parentFolderId;
	}

	public List<Folder> getSubFolders() {
		return subFolders;
	}

	public void setSubFolders(List<Folder> subFolders) {
		this.subFolders = subFolders;
	}

	public List<File> getFiles() {
		return files;
	}

	public void setFiles(List<File> files) {
		this.files = files;
	}

	public long getRepositoryId() {
		return repositoryId;
	}

	public void setRepositoryId(long repositoryId) {
		this.repositoryId = repositoryId;
	}
	
	public void tryAddSubFolder(Folder subFolder){
		if(subFolder.getParentFolderId() == this.folderId){
			this.subFolders.add(subFolder);
		} else {
			for(Folder subFolder2 : this.subFolders){
				subFolder2.tryAddSubFolder(subFolder);
			}
		}
	}

}
