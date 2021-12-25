package entity;

import java.time.LocalDate;
import java.util.Arrays;

public class Exam {
	public int id;
	public int code;
	public String title;
	public CategoryQuestion categoryQuestion;
	public int duration;
	public Account creator;
	public LocalDate creaDate;
	public Question[] questions;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public CategoryQuestion getCategoryQuestion() {
		return categoryQuestion;
	}

	public void setCategoryQuestion(CategoryQuestion categoryQuestion) {
		this.categoryQuestion = categoryQuestion;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public Account getCreator() {
		return creator;
	}

	public void setCreator(Account creator) {
		this.creator = creator;
	}

	public LocalDate getCreaDate() {
		return creaDate;
	}

	public void setCreaDate(LocalDate creaDate) {
		this.creaDate = creaDate;
	}

	public Question[] getQuestions() {
		return questions;
	}

	public void setQuestions(Question[] questions) {
		this.questions = questions;
	}

	@Override
	public String toString() {
		return "Exam [id=" + id + ", code=" + code + ", title=" + title + ", categoryQuestion=" + categoryQuestion
				+ ", duration=" + duration + ", creator=" + creator + ", creaDate=" + creaDate + ", questions="
				+ Arrays.toString(questions) + "]";
	}

}
