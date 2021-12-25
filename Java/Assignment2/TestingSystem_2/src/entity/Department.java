package entity;

public class Department {
	public int id;
	public String name;

	public void printDepartment() {
		System.out.println("Th�ng tin ph�ng ban: " + id + ", T�n :" + name);
	}

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

	@Override
	public String toString() {
		return "Department [id = " + id + ", name = " + name + "]";
	}

}
