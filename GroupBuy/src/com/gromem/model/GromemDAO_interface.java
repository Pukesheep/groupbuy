package com.gromem.model;

import java.util.*;
import com.member.model.*;

public interface GromemDAO_interface {

	public void insert(GromemVO gromemVO);
	public void delete(String mem_id, String gro_id);
	public List<GromemVO> findByMem_id(String mem_id);
	public List<GromemVO> findByGro_id(String gro_id);
	public List<GromemVO> getAll();
	public void join(GromemVO gromemVO, Integer people);
	public void quit(GromemVO gromemVO, Integer people);
	public GromemVO findByCompositeKey(String mem_id, String gro_id);
	
}
