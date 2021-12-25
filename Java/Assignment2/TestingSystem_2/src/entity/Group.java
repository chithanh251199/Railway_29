package entity;

import java.time.LocalDate;
import java.util.Arrays;

public class Group {
	public int id;
	public String name;
	public Account creatorid;
	public LocalDate createDate;
	public Account[] accounts;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Account getCreatorid() {
		return creatorid;
	}

	public void setCreatorid(Account creatorid) {
		this.creatorid = creatorid;
	}

	public LocalDate getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDate createDate) {
		this.createDate = createDate;
	}

	public Account[] getAccounts() {
		return accounts;
	}

	public void setAccounts(Account[] accounts) {
		this.accounts = accounts;
	}

	@Override
	public String toString() {
		return "Group [id=" + id + ", name=" + name + ", creatorid=" + creatorid + ", createDate=" + createDate
				+ ", accounts=" + Arrays.toString(accounts) + "]";
	}

}
